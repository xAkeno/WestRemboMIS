<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;
use App\Traits\ExtractsUserFromAuthToken;

/**
 * ReleaseDocumentController
 *
 * Routes to add in api.php:
 *   POST   /api/documents/release/{documentType}/{id}   → release (upload PDF + set status)
 *   GET    /api/documents/release/{documentType}/{id}/download → get signed S3 URL
 *
 * Example:
 *   Route::post('documents/release/{documentType}/{id}', [ReleaseDocumentController::class, 'release']);
 *   Route::get('documents/release/{documentType}/{id}/download', [ReleaseDocumentController::class, 'download']);
 */
class ReleaseDocumentController extends Controller
{
    use ExtractsUserFromAuthToken;

    /**
     * Map URL segment → Eloquent model class
     */
    private const MODEL_MAP = [
        'barangay-certificates' => \App\Models\BarangayCertificate::class,
        'barangay-clearances'   => \App\Models\BarangayClearance::class,
        'building-clearances'   => \App\Models\BuildingClearance::class,
        'business-clearances'   => \App\Models\BusinessClearance::class,
    ];

    /**
     * POST /api/documents/release/{documentType}/{id}
     *
     * Expects multipart/form-data:
     *   - file: the generated PDF blob (binary)
     *
     * Sets status = 'released', uploads PDF to S3, saves path.
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

            // Build a clean S3 path: released_documents/{type}/{id}_{bcert}.pdf
            $bcertSlug = preg_replace('/[^a-zA-Z0-9\-_]/', '_', $record->bcert_number ?? (string) $id);
            $filename  = "{$id}_{$bcertSlug}.pdf";
            $s3Path    = "released_documents/{$documentType}/{$filename}";

            // Delete previous released file if it exists
            if (!empty($record->released_document_path)) {
                try {
                    Storage::disk('s3')->delete($record->released_document_path);
                } catch (\Throwable $e) {
                    Log::warning("S3 delete (release) failed: " . $e->getMessage());
                }
            }

            // Upload to S3
            Storage::disk('s3')->putFileAs(
                "released_documents/{$documentType}",
                $file,
                $filename
            );

            // Update the record
            $record->update([
                'status'                 => 'released',
                'released_document_path' => $s3Path,
                'released_at'            => now(),
            ]);

            return response()->json([
                'status'  => 'success',
                'message' => 'Document released and uploaded successfully.',
                'data'    => [
                    'id'                     => $record->id,
                    'status'                 => 'released',
                    'released_document_path' => $s3Path,
                    'released_at'            => $record->released_at,
                ],
            ]);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Validation failed.',
                'errors'  => $e->errors(),
            ], 422);

        } catch (\Exception $e) {
            Log::error("Release document failed: " . $e->getMessage());

            return response()->json([
                'status'  => 'error',
                'message' => 'Failed to release document: ' . $e->getMessage(),
            ], 500);
        }
    }

    /**
     * GET /api/documents/release/{documentType}/{id}/download
     *
     * Returns a 15-minute signed S3 URL for the released PDF.
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
                    'expires_in' => 900, // seconds
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
