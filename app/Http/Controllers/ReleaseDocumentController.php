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
use setasign\Fpdi\Tcpdf\Fpdi as TcpdfFpdi;

class ReleaseDocumentController extends Controller
{
    use ExtractsUserFromAuthToken;

    private const MODEL_MAP = [
        'barangay-certificates' => \App\Models\BarangayCertificate::class,
        'barangay-clearances'   => \App\Models\BarangayClearance::class,
        'building-clearances'   => \App\Models\BarangayBuildingClearance::class,
        'business-clearances'   => \App\Models\BarangayBusinessClearance::class,
    ];

    private function generatePassword(string $firstName, string $lastName, int $age): string
    {
        return strlen(trim($firstName)) . trim($lastName) . $age;
    }

    private function normalizePdf(string $inputPath): string
    {
        $outputPath = tempnam(sys_get_temp_dir(), 'norm_') . '.pdf';

        $gsBinary = strtoupper(substr(PHP_OS, 0, 3)) === 'WIN'
            ? 'gswin64c'
            : 'gs';

        $cmd = "$gsBinary -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dBATCH -sOutputFile=\"$outputPath\" \"$inputPath\" 2>&1";
        exec($cmd, $output, $returnVar);

        Log::info('Ghostscript output:', $output);
        Log::info('Ghostscript return code: ' . $returnVar);

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

        $pageCount = $pdf->setSourceFile($inputPath);

        for ($i = 1; $i <= $pageCount; $i++) {
            $tplId = $pdf->importPage($i);
            $size  = $pdf->getTemplateSize($tplId);

            $pdf->AddPage($size['orientation'], [$size['width'], $size['height']]);
            $pdf->useTemplate($tplId, 0, 0, $size['width'], $size['height'], true);
        }

        $pdf->SetProtection(
            ['print'],
            $password,
            null,
            3,
            null
        );

        $outputPath = tempnam(sys_get_temp_dir(), 'enc_pdf_') . '.pdf';
        $pdf->Output($outputPath, 'F');

        if (!file_exists($outputPath) || filesize($outputPath) === 0) {
            throw new \Exception('Encrypted PDF was not created or is empty.');
        }

        return $outputPath;
    }

    /**
     * POST /api/documents/release/{documentType}/{id}
     * Can also accept ?status=PROCESS query parameter for different status
     */
    public function release(Request $request, string $documentType, int $id): JsonResponse
    {
        $encryptedTempPath = null;
        $emailSent = false;
        $emailError = null;
        
        // Get the target status from query parameter (default to RELEASED)
        $targetStatus = strtoupper($request->query('status', 'RELEASED'));
        
        // Validate target status
        if (!in_array($targetStatus, ['RELEASED', 'PROCESS'])) {
            return response()->json([
                'status' => 'error',
                'message' => 'Invalid status parameter. Allowed values: RELEASED, PROCESS',
            ], 422);
        }

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
            $realPath = $file->getRealPath();

            // ── 1. GENERATE PASSWORD ──────────────────────────────────────────
            $firstName = $record->first_name ?? '';
            $lastName  = $record->surname    ?? '';
            $age       = (int) ($record->age ?? 0);

            $password = $this->generatePassword($firstName, $lastName, $age);

            Log::info("Password generated for record #{$id} for status {$targetStatus}: {$password}");

            // ── 2. ENCRYPT PDF ────────────────────────────────────────────────
            $encryptedTempPath = $this->encryptPdf($realPath, $password);
            $encryptedContent  = file_get_contents($encryptedTempPath);

            if (!$encryptedContent) {
                throw new \Exception('Failed to read encrypted PDF content.');
            }

            // ── 3. HASH THE ENCRYPTED PDF ─────────────────────────────────────
            $hash = hash('sha256', $encryptedContent);

            // ── 4. UPLOAD ENCRYPTED PDF TO S3 ────────────────────────────────
            $bcertSlug = preg_replace(
                '/[^a-zA-Z0-9\-_]/',
                '_',
                $record->bcert_number ?? (string) $id
            );
            $statusFolder = strtolower($targetStatus);
            $filename = "{$id}_{$bcertSlug}.pdf";
            $s3Path   = "{$statusFolder}_documents/{$documentType}/{$filename}";

            // Delete old document if exists
            if ($targetStatus === 'RELEASED' && !empty($record->released_document_path)) {
                Storage::disk('s3')->delete($record->released_document_path);
            }
            if ($targetStatus === 'PROCESS' && !empty($record->process_document_path)) {
                Storage::disk('s3')->delete($record->process_document_path);
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

            // ── 6. UPDATE RECORD BASED ON TARGET STATUS ───────────────────────
            if ($targetStatus === 'RELEASED') {
                $record->update([
                    'status'                 => 'RELEASED',
                    'released_document_path' => $s3Path,
                    'released_at'            => now(),
                    'document_hash'          => $hash,
                    'ipfs_cid'               => $cid,
                    'issued_date'            => $record->issued_date ?? now(),
                    'issued_at'              => $record->issued_at   ?? 'Barangay Hall',
                    'issued_on'              => $record->issued_on   ?? now(),
                    'expires_at'             => now()->addMonths(6),
                ]);
            } else {
                // For PROCESS status - store in separate fields
                $record->update([
                    'status'                    => 'PROCESS',
                    'process_document_path'     => $s3Path,
                    'process_document_sent_at'  => now(),
                    'process_document_hash'     => $hash,
                    'process_ipfs_cid'          => $cid,
                ]);
            }

            // ── 7. TICKET SYNC (only for RELEASED) ────────────────────────────
            if ($targetStatus === 'RELEASED') {
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
            }

            // ── 8. SEND EMAIL (BEFORE FILE CLEANUP!) ──────────────────────────
            if (!empty($record->email)) {
                try {
                    Log::info("Sending {$targetStatus} document email to: {$record->email}", [
                        'record_id' => $record->id,
                        'temp_file_exists' => file_exists($encryptedTempPath),
                    ]);

                    Mail::to($record->email)->send(
                        new ReleasedDocumentMail($record, $encryptedTempPath, $password, $targetStatus)
                    );

                    $emailSent = true;
                    Log::info("Email sent successfully to: {$record->email}");

                } catch (\Exception $mailError) {
                    $emailError = $mailError->getMessage();
                    Log::error("Email sending failed: {$emailError}", [
                        'record_id' => $record->id,
                        'email' => $record->email,
                        'exception' => get_class($mailError),
                    ]);
                }
            } else {
                Log::warning("No email address for record #{$record->id}");
            }

            // ── 9. RETURN RESPONSE ────────────────────────────────────────────
            $responseData = [
                'id'         => $record->id,
                'status'     => $targetStatus,
                'file'       => $s3Path,
                'cid'        => $cid,
                'hash'       => $hash,
                'password'   => $password,
                'email_sent' => $emailSent,
            ];

            if ($emailError) {
                $responseData['email_error'] = $emailError;
            }

            return response()->json([
                'status'  => 'success',
                'message' => "Document marked as {$targetStatus}, encrypted, and" . ($emailSent ? ' emailed' : ' queued for email') . ' successfully.',
                'data'    => $responseData,
            ]);

        } catch (\Exception $e) {
            Log::error("Release document failed: " . $e->getMessage(), [
                'exception' => get_class($e),
                'trace' => $e->getTraceAsString(),
            ]);

            return response()->json([
                'status'  => 'error',
                'message' => $e->getMessage(),
                'email_sent' => $emailSent,
                'email_error' => $emailError,
            ], 500);

        } finally {
            // ✅ CLEANUP: Delete temp file after everything is done
            if ($encryptedTempPath && file_exists($encryptedTempPath)) {
                if (@unlink($encryptedTempPath)) {
                    Log::debug("Cleaned up encrypted temp file: {$encryptedTempPath}");
                } else {
                    Log::warning("Failed to delete temp file: {$encryptedTempPath}");
                }
            }
        }
    }

    /**
     * POST /api/documents/verify
     */
    public function verify(Request $request): JsonResponse
    {
        try {
            $request->validate(['file' => 'required|file|mimes:pdf']);
    
            $hash = hash('sha256', file_get_contents($request->file('file')->getRealPath()));
    
            foreach (self::MODEL_MAP as $documentType => $modelClass) {
    
                // ── Check released hash (encrypted PDF) ──────────────────────────
                $record = $modelClass::where('document_hash', $hash)->first();
                $source = 'released';
    
                // ── Check downloaded hash (plain PDF) ────────────────────────────
                if (!$record) {
                    $record = $modelClass::where('downloaded_document_hash', $hash)->first();
                    $source = 'downloaded';
                }
    
                if ($record) {
                    $maskedName =
                        strtoupper(substr($record->first_name ?? '?', 0, 1)) . '*** ' .
                        strtoupper(substr($record->surname    ?? '?', 0, 1)) . '***';
    
                    // Use the right date/expiry depending on source
                    if ($source === 'released') {
                        $issuedDate = $record->issued_date;
                        $expiresAt  = $issuedDate
                            ? \Carbon\Carbon::parse($issuedDate)->addYear()
                            : null;
                        $cid        = $record->ipfs_cid;
                    } else {
                        // Downloaded docs: use downloaded_at as the reference date
                        $issuedDate = $record->downloaded_at
                            ? \Carbon\Carbon::parse($record->downloaded_at)->toDateString()
                            : null;
                        // Downloaded docs expire 6 months after download
                        $expiresAt  = $issuedDate
                            ? \Carbon\Carbon::parse($issuedDate)->addMonths(6)
                            : null;
                        $cid        = $record->downloaded_ipfs_cid;
                    }
    
                    return response()->json([
                        'valid'   => true,
                        'message' => 'Document is authentic',
                        'data'    => [
                            'cid'         => $cid,
                            'record_id'   => $record->id,
                            'type'        => $documentType,
                            'source'      => $source,   // 'released' or 'downloaded'
                            'name'        => $maskedName,
                            'issued_date' => $issuedDate,
                            'expires_at'  => $expiresAt,
                            'is_expired'  => $expiresAt ? now()->gt($expiresAt) : false,
                        ],
                    ]);
                }
            }
    
            return response()->json([
                'valid'   => false,
                'message' => 'Document is NOT authentic',
            ]);
    
        } catch (\Exception $e) {
            return response()->json([
                'status'  => 'error',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * GET /api/documents/release/barangay-clearances/{id}/download
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

    public function downloadRegister(Request $request, string $documentType, int $id): JsonResponse
    {
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
            $pdfBytes = file_get_contents($file->getRealPath());
    
            if (!$pdfBytes) {
                throw new \Exception('Failed to read uploaded PDF.');
            }
    
            // ── 1. HASH ──────────────────────────────────────────────────────────
            $hash = hash('sha256', $pdfBytes);
    
            // ── 2. BUILD S3 PATH ─────────────────────────────────────────────────
            $bcertSlug = preg_replace(
                '/[^a-zA-Z0-9\-_]/',
                '_',
                $record->bcert_number ?? (string) $id
            );
            $filename = "{$id}_{$bcertSlug}.pdf";
            $s3Path   = "downloaded_documents/{$documentType}/{$filename}";
    
            // Delete old downloaded copy if it exists
            if (!empty($record->downloaded_document_path)) {
                Storage::disk('s3')->delete($record->downloaded_document_path);
            }
    
            // ── 3. UPLOAD TO S3 ──────────────────────────────────────────────────
            Storage::disk('s3')->put($s3Path, $pdfBytes);
    
            // ── 4. UPLOAD TO PINATA (IPFS) ───────────────────────────────────────
            $pinataResponse = Http::withHeaders([
                'pinata_api_key'        => env('PINATA_API_KEY'),
                'pinata_secret_api_key' => env('PINATA_SECRET_API_KEY'),
            ])->attach('file', $pdfBytes, $filename)
            ->post('https://api.pinata.cloud/pinning/pinFileToIPFS');
    
            if (!$pinataResponse->successful()) {
                throw new \Exception('Pinata upload failed: ' . $pinataResponse->body());
            }
    
            $cid = $pinataResponse->json()['IpfsHash'];
    
            // ── 5. PERSIST TO DB (no status change, no email) ────────────────────
            $record->update([
                'downloaded_document_path' => $s3Path,
                'downloaded_at'            => now(),
                'downloaded_document_hash' => $hash,
                'downloaded_ipfs_cid'      => $cid,
            ]);
    
            Log::info("Download registered for {$documentType}#{$id}", [
                'cid'  => $cid,
                'hash' => $hash,
                's3'   => $s3Path,
            ]);
    
            // ── 6. GENERATE SIGNED URL (15 min) ──────────────────────────────────
            $signedUrl = Storage::disk('s3')->temporaryUrl(
                $s3Path,
                now()->addMinutes(15)
            );
    
            return response()->json([
                'status'  => 'success',
                'message' => 'Document registered and ready for download.',
                'data'    => [
                    'url'        => $signedUrl,
                    'expires_in' => 900,
                    'filename'   => $filename,
                    'cid'        => $cid,
                    'hash'       => $hash,
                ],
            ]);
    
        } catch (\Exception $e) {
            Log::error("downloadRegister failed: " . $e->getMessage(), [
                'documentType' => $documentType,
                'id'           => $id,
                'trace'        => $e->getTraceAsString(),
            ]);
    
            return response()->json([
                'status'  => 'error',
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}