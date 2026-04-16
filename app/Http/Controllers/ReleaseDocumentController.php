<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;
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

            if (!empty($record->released_document_path)) {
                Storage::disk('s3')->delete($record->released_document_path);
            }

            Storage::disk('s3')->putFileAs(
                "released_documents/{$documentType}",
                $file,
                $filename
            );

            $record->update([
                'status'                 => 'RELEASED',
                'released_document_path' => $s3Path,
                'released_at'            => now(),

                // ✅ AUTO FILL ISSUANCE DATA
                'issued_date' => $record->issued_date ?? now(),
                'issued_at'   => $record->issued_at ?? 'Barangay Hall',
                'issued_on'   => $record->issued_on ?? now()
            ]);

            // 1. Try direct relation match first (schedule/system-generated)
            $ticket = \App\Models\Ticket::where('serviceable_type', $modelClass)
                ->where('serviceable_id', $record->id)
                ->first();

            // 2. If not found, fallback to Kiosk matching
            // FIX: Kiosk stores `surname`, not `last_name`
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

            // 3. Update ticket if found
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
                'message' => 'Document released and ticket synced successfully.',
                'data'    => [
                    'id'     => $record->id,
                    'status' => 'RELEASED',
                    'file'   => $s3Path,
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
     * GET /api/documents/release/{documentType}/{id}/download
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