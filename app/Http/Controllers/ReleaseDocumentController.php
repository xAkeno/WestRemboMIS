<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Mail;
use App\Traits\ExtractsUserFromAuthToken;
use App\Mail\ReleasedDocumentMail;
use setasign\Fpdi\Tcpdf\Fpdi as TcpdfFpdi; // requires: composer require setasign/fpdi tecnickcom/tcpdf

class ReleaseDocumentController extends Controller
{
    use ExtractsUserFromAuthToken;

    private const MODEL_MAP = [
        'barangay-certificates' => \App\Models\BarangayCertificate::class,
        'barangay-clearances'   => \App\Models\BarangayClearance::class,
        'building-clearances'   => \App\Models\BarangayBuildingClearance::class,
        'business-clearances'   => \App\Models\BarangayBusinessClearance::class,
    ];

    /**
     * Generate password: strlen(firstname) + lastname + age
     *
     * Example: firstname="Juan" (4 chars), lastname="Cruz", age=25
     * Result  => "4Cruz25"
     */
    private function generatePassword(string $firstName, string $lastName, int $age): string
    {
        return strlen(trim($firstName)) . trim($lastName) . $age;
    }

    /**
     * Encrypt a PDF using TCPDF + FPDI — pure PHP, works on Windows.
     *
     * Reads the original PDF page-by-page with FPDI, then applies
     * TCPDF's AES-256 SetProtection before saving to a temp file.
     *
     * Composer deps needed:
     *   composer require tecnickcom/tcpdf setasign/fpdi
     *
     * @param  string $inputPath  Absolute path to the original (unencrypted) PDF
     * @param  string $password   User password (what the recipient types to open)
     * @return string             Absolute path to the encrypted temp PDF
     * @throws \Exception
     */

    private function normalizePdf(string $inputPath): string
    {
        $outputPath = tempnam(sys_get_temp_dir(), 'norm_') . '.pdf';

        $gsBinary = strtoupper(substr(PHP_OS, 0, 3)) === 'WIN'
            ? 'gswin64c'
            : 'gs';

        $cmd = "$gsBinary -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dBATCH -sOutputFile=\"$outputPath\" \"$inputPath\" 2>&1";
        exec($cmd, $output, $returnVar);

        // 👇 LOG EVERYTHING
        \Log::error('Ghostscript output:', $output);
        \Log::error('Ghostscript return code: ' . $returnVar);

        if ($returnVar !== 0 || !file_exists($outputPath)) {
            throw new \Exception('Ghostscript failed: ' . implode("\n", $output));
        }

        return $outputPath;
    }

    private function encryptPdf(string $inputPath, string $password): string
    {
        $inputPath = $this->normalizePdf($inputPath);

        $pdf = new TcpdfFpdi('P', 'pt');

        $pdf->SetAutoPageBreak(false);
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);

        // Import every page from the source PDF
        $pageCount = $pdf->setSourceFile($inputPath);

        for ($i = 1; $i <= $pageCount; $i++) {
            $tplId = $pdf->importPage($i);
            $size  = $pdf->getTemplateSize($tplId);

            $pdf->AddPage($size['orientation'], [$size['width'], $size['height']]);
            $pdf->useTemplate($tplId, 0, 0, $size['width'], $size['height'], true);
        }

        // AES-256 encryption
        // permissions: ['print'] = recipient can print but not copy/edit
        // mode 3 = AES-256
        $pdf->SetProtection(
            ['print'],   // allowed permissions
            $password,   // user password (to open)
            null,        // owner password (null = random)
            3,           // encryption mode: 3 = AES-256
            null
        );

        $outputPath = tempnam(sys_get_temp_dir(), 'enc_pdf_') . '.pdf';
        $pdf->Output($outputPath, 'F'); // 'F' = write to file

        if (!file_exists($outputPath) || filesize($outputPath) === 0) {
            throw new \Exception('Encrypted PDF was not created or is empty.');
        }

        return $outputPath;
    }

    /**
     * POST /api/documents/release/{documentType}/{id}
     */
    public function release(Request $request, string $documentType, int $id): JsonResponse
    {
        $encryptedTempPath = null;

        try {
            $modelClass = self::MODEL_MAP[$documentType] ?? null;

            if (!$modelClass) {
                return response()->json([
                    'status'  => 'error',
                    'message' => "Unknown document type: {$documentType}",
                ], 422);
            }

            $request->validate([
                'file' => 'required|file|mimes:pdf|max:20480',
            ]);

            /** @var \Illuminate\Database\Eloquent\Model $record */
            $record   = $modelClass::findOrFail($id);
            $file     = $request->file('file');
            $realPath = $file->getRealPath(); // grab BEFORE anything moves the temp file

            // ── 1. GENERATE PASSWORD ──────────────────────────────────────────
            // Pattern: strlen(firstname) + lastname + age
            // e.g.  "Juan" → 4,  surname="Cruz",  age=25  →  "4Cruz25"
            $firstName = $record->first_name ?? '';
            $lastName  = $record->surname    ?? '';
            $age       = (int) ($record->age ?? 0);

            $password = $this->generatePassword($firstName, $lastName, $age);

            Log::info("Password generated for record #{$id}: {$password}");

            // ── 2. ENCRYPT PDF ────────────────────────────────────────────────
            $encryptedTempPath = $this->encryptPdf($realPath, $password);
            $encryptedContent  = file_get_contents($encryptedTempPath);

            // ── 3. HASH THE ENCRYPTED PDF ─────────────────────────────────────
            // Always hash the encrypted version so verification works when
            // the recipient uploads the same password-protected file back.
            $hash = hash('sha256', $encryptedContent);

            // ── 4. UPLOAD ENCRYPTED PDF TO S3 ────────────────────────────────
            $bcertSlug = preg_replace(
                '/[^a-zA-Z0-9\-_]/',
                '_',
                $record->bcert_number ?? (string) $id
            );
            $filename = "{$id}_{$bcertSlug}.pdf";
            $s3Path   = "released_documents/{$documentType}/{$filename}";

            if (!empty($record->released_document_path)) {
                Storage::disk('s3')->delete($record->released_document_path);
            }

            Storage::disk('s3')->put($s3Path, $encryptedContent);

            // ── 5. UPLOAD ENCRYPTED PDF TO PINATA ────────────────────────────
            $pinataResponse = Http::withHeaders([
                'pinata_api_key'        => env('PINATA_API_KEY'),
                'pinata_secret_api_key' => env('PINATA_SECRET_API_KEY'),
            ])->attach('file', $encryptedContent, $filename)
              ->post('https://api.pinata.cloud/pinning/pinFileToIPFS');

            if (!$pinataResponse->successful()) {
                throw new \Exception('Pinata upload failed: ' . $pinataResponse->body());
            }

            $cid = $pinataResponse->json()['IpfsHash'];

            // ── 6. UPDATE RECORD ──────────────────────────────────────────────
            $record->update([
                'status'                 => 'RELEASED',
                'released_document_path' => $s3Path,
                'released_at'            => now(),
                'document_hash'          => $hash,
                'ipfs_cid'               => $cid,
                'issued_date'            => $record->issued_date ?? now(),
                'issued_at'              => $record->issued_at   ?? 'Barangay Hall',
                'issued_on'              => $record->issued_on   ?? now(),
            ]);

            // ── 7. TICKET SYNC ────────────────────────────────────────────────
            $ticket = \App\Models\Ticket::where('serviceable_type', $modelClass)
                ->where('serviceable_id', $record->id)
                ->first();

            if (!$ticket) {
                $kiosk = \App\Models\Kiosk::where('service_type', 'Barangay Clearance')
                    ->whereRaw('LOWER(first_name) = ?', [strtolower($record->first_name)])
                    ->whereRaw('LOWER(surname)    = ?', [strtolower($record->surname)])
                    ->first();

                if ($kiosk) {
                    $ticket = \App\Models\Ticket::where('serviceable_type', 'App\\Models\\Kiosk')
                        ->where('serviceable_id', $kiosk->id)
                        ->first();
                }
            }

            if ($ticket) {
                $ticket->update(['status' => 'Released', 'released_at' => now()]);
            } else {
                Log::warning("No ticket found for released document", [
                    'type' => $documentType,
                    'id'   => $id,
                    'name' => "{$record->first_name} {$record->surname}",
                ]);
            }

            // ── 8. SEND EMAIL ─────────────────────────────────────────────────
            // ReleasedDocumentMail receives:
            //   $record          → for addressee details in the email body
            //   $encryptedTempPath → the encrypted PDF to attach
            //   $password        → shown in the email body so recipient can open it
            if (!empty($record->email)) {
                try {
                    Mail::to($record->email)->send(
                        new ReleasedDocumentMail($record, $encryptedTempPath, $password)
                    );
                    Log::info("Email sent to {$record->email}");
                } catch (\Exception $mailError) {
                    Log::error("Email failed: " . $mailError->getMessage());
                }
            } else {
                Log::warning("No email for record #{$record->id}");
            }

            return response()->json([
                'status'  => 'success',
                'message' => 'Document released, encrypted, and emailed successfully.',
                'data'    => [
                    'id'       => $record->id,
                    'status'   => 'RELEASED',
                    'file'     => $s3Path,
                    'cid'      => $cid,
                    'hash'     => $hash,
                    'password' => $password,
                ],
            ]);

        } catch (\Exception $e) {
            Log::error("Release document failed: " . $e->getMessage());
            return response()->json(['status' => 'error', 'message' => $e->getMessage()], 500);

        } finally {
            // Always delete the encrypted temp file regardless of outcome
            if ($encryptedTempPath && file_exists($encryptedTempPath)) {
                @unlink($encryptedTempPath);
            }
        }
    }

    /**
     * POST /api/documents/verify
     *
     * The user must upload the same encrypted PDF they received.
     * The SHA-256 of that file is compared against the stored hash.
     */
    public function verify(Request $request): JsonResponse
    {
        try {
            $request->validate(['file' => 'required|file|mimes:pdf']);

            $hash = hash('sha256', file_get_contents($request->file('file')->getRealPath()));

            foreach (self::MODEL_MAP as $modelClass) {
                $record = $modelClass::where('document_hash', $hash)->first();

                if ($record) {
                    $maskedName =
                        strtoupper(substr($record->first_name, 0, 1)) . '*** ' .
                        strtoupper(substr($record->surname, 0, 1)) . '***';

                    $issuedDate = $record->issued_date;
                    $expiresAt  = $issuedDate
                        ? \Carbon\Carbon::parse($issuedDate)->addYear()
                        : null;

                    return response()->json([
                        'valid'   => true,
                        'message' => 'Document is authentic',
                        'data'    => [
                            'cid'         => $record->ipfs_cid,
                            'record_id'   => $record->id,
                            'type'        => $modelClass,
                            'name'        => $maskedName,
                            'issued_date' => $issuedDate,
                            'expires_at'  => $expiresAt,
                            'is_expired'  => $expiresAt ? now()->gt($expiresAt) : false,
                        ],
                    ]);
                }
            }

            return response()->json(['valid' => false, 'message' => 'Document is NOT authentic']);

        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => $e->getMessage()], 500);
        }
    }

    /**
     * GET /api/documents/download/{documentType}/{id}
     */
    public function download(string $documentType, int $id): JsonResponse
    {
        try {
            $modelClass = self::MODEL_MAP[$documentType] ?? null;

            if (!$modelClass) {
                return response()->json(['status' => 'error', 'message' => "Unknown document type: {$documentType}"], 422);
            }

            $record = $modelClass::findOrFail($id);

            if (empty($record->released_document_path)) {
                return response()->json(['status' => 'error', 'message' => 'No released document found.'], 404);
            }

            if (!Storage::disk('s3')->exists($record->released_document_path)) {
                return response()->json(['status' => 'error', 'message' => 'File not found in storage.'], 404);
            }

            $signedUrl = Storage::disk('s3')->temporaryUrl(
                $record->released_document_path,
                now()->addMinutes(15)
            );

            return response()->json([
                'status' => 'success',
                'data'   => [
                    'url'        => $signedUrl,
                    'expires_in' => 900,
                    'filename'   => basename($record->released_document_path),
                ],
            ]);

        } catch (\Exception $e) {
            Log::error("Download signed URL failed: " . $e->getMessage());
            return response()->json(['status' => 'error', 'message' => $e->getMessage()], 500);
        }
    }
}