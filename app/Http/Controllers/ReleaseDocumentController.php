<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Http;
use App\Traits\ExtractsUserFromAuthToken;

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
     * POST /api/documents/release/{documentType}/{id}
     */
    public function release(Request $request, string $documentType, int $id): JsonResponse
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
            $record = $modelClass::findOrFail($id);

            $file = $request->file('file');

            $bcertSlug = preg_replace(
                '/[^a-zA-Z0-9\-_]/',
                '_',
                $record->bcert_number ?? (string) $id
            );

            $filename = "{$id}_{$bcertSlug}.pdf";
            $s3Path   = "released_documents/{$documentType}/{$filename}";

            // Delete old file if exists
            if (!empty($record->released_document_path)) {
                Storage::disk('s3')->delete($record->released_document_path);
            }

            // Upload to S3
            Storage::disk('s3')->putFileAs(
                "released_documents/{$documentType}",
                $file,
                $filename
            );

            // ===============================
            // 🔐 HASH + PINATA UPLOAD
            // ===============================

            $fileContent = file_get_contents($file->getRealPath());

            // SHA-256 hash
            $hash = hash('sha256', $fileContent);

            // Upload to Pinata
            $response = Http::withHeaders([
                'pinata_api_key' => env('PINATA_API_KEY'),
                'pinata_secret_api_key' => env('PINATA_SECRET_API_KEY'),
            ])->attach(
                'file',
                $fileContent,
                $filename
            )->post('https://api.pinata.cloud/pinning/pinFileToIPFS');

            if (!$response->successful()) {
                throw new \Exception('Pinata upload failed: ' . $response->body());
            }

            $cid = $response->json()['IpfsHash'];

            // ===============================
            // UPDATE RECORD
            // ===============================
            $record->update([
                'status'                 => 'RELEASED',
                'released_document_path' => $s3Path,
                'released_at'            => now(),

                // NEW 👇
                'document_hash' => $hash,
                'ipfs_cid'      => $cid,

                'issued_date' => $record->issued_date ?? now(),
                'issued_at'   => $record->issued_at ?? 'Barangay Hall',
                'issued_on'   => $record->issued_on ?? now()
            ]);

            // ===============================
            // TICKET SYNC
            // ===============================

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
                $ticket->update([
                    'status'      => 'Released',
                    'released_at' => now(),
                ]);
            } else {
                Log::warning("No ticket found for released document", [
                    'type' => $documentType,
                    'id'   => $id,
                    'name' => $record->first_name . ' ' . $record->surname,
                ]);
            }

            return response()->json([
                'status'  => 'success',
                'message' => 'Document released + stored in IPFS successfully.',
                'data'    => [
                    'id'     => $record->id,
                    'status' => 'RELEASED',
                    'file'   => $s3Path,
                    'cid'    => $cid,
                    'hash'   => $hash,
                ],
            ]);

        } catch (\Exception $e) {
            Log::error("Release document failed: " . $e->getMessage());

            return response()->json([
                'status'  => 'error',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * VERIFY DOCUMENT
     * POST /api/documents/verify
     */
    public function verify(Request $request): JsonResponse
    {
        try {
            $request->validate([
                'file' => 'required|file|mimes:pdf',
            ]);

            $file = $request->file('file');
            $hash = hash('sha256', file_get_contents($file));

            foreach (self::MODEL_MAP as $modelClass) {

                $record = $modelClass::where('document_hash', $hash)->first();

                if ($record) {

                    // =========================
                    // MASK NAME
                    // =========================
                    $maskedName =
                        strtoupper(substr($record->first_name, 0, 1)) . '*** ' .
                        strtoupper(substr($record->surname, 0, 1)) . '***';

                    // =========================
                    // EXPIRY CHECK (default 1 year validity)
                    // =========================
                    $issuedDate = $record->issued_date;

                    $expired = false;
                    $expiresAt = null;

                    if ($issuedDate) {
                        $expiresAt = \Carbon\Carbon::parse($issuedDate)->addYear();
                        $expired = now()->gt($expiresAt);
                    }

                    return response()->json([
                        'valid' => true,
                        'message' => 'Document is authentic',
                        'data' => [
                            'cid' => $record->ipfs_cid,
                            'record_id' => $record->id,
                            'type' => $modelClass,

                            // 👇 NEW
                            'name' => $maskedName,
                            'issued_date' => $issuedDate,
                            'expires_at' => $expiresAt,
                            'is_expired' => $expired,
                        ]
                    ]);
                }
            }

            return response()->json([
                'valid' => false,
                'message' => 'Document is NOT authentic',
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * DOWNLOAD (UNCHANGED)
     */
    public function download(string $documentType, int $id): JsonResponse
    {
        try {
            $modelClass = self::MODEL_MAP[$documentType] ?? null;

            if (!$modelClass) {
                return response()->json([
                    'status'  => 'error',
                    'message' => "Unknown document type: {$documentType}",
                ], 422);
            }

            $record = $modelClass::findOrFail($id);

            if (empty($record->released_document_path)) {
                return response()->json([
                    'status'  => 'error',
                    'message' => 'No released document found for this record.',
                ], 404);
            }

            if (!Storage::disk('s3')->exists($record->released_document_path)) {
                return response()->json([
                    'status'  => 'error',
                    'message' => 'Released document file not found in storage.',
                ], 404);
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

            return response()->json([
                'status'  => 'error',
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}