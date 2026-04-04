<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\DocumentUpload;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use App\Traits\ExtractsUserFromAuthToken;
use Illuminate\Support\Facades\Log;
class DocumentUploadController extends Controller
{
    use ExtractsUserFromAuthToken;
    private const ALLOWED_MIMES = [
        'image/jpeg',
        'image/png',
        'image/webp',
        'application/pdf',
    ];

    private const MAX_SIZE_KB = 10240; // 10 MB

    // ── GET /api/documents ─────────────────────────────────────────────────────
    public function index(Request $request): JsonResponse
    {
        try {
            // 🔥 PRIORITY: use requested user_id if provided
            $userId = $request->input('user_id')
                ? (int) $request->input('user_id')
                : $this->getUserIdFromAuthToken();

            $uploads = DocumentUpload::where('user_id', $userId)
                ->get()
                ->groupBy('category')
                ->map(fn ($group) => $group->map(fn ($doc) => $this->format($doc)));

            return response()->json([
                'status' => 'success',
                'data'   => [
                    'documents' => $uploads,
                    'all_required_uploaded' => DocumentUpload::allRequiredUploaded($userId),
                ],
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    // ── POST /api/documents/upload ─────────────────────────────────────────────
    public function upload(Request $request): JsonResponse
    {
        try {
            $userId = $this->getUserIdFromAuthToken(); // ✅ YOUR SYSTEM

            if (!$userId) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Unauthenticated',
                ], 401);
            }

            $request->validate([
                'type' => ['required', 'string', function ($attr, $value, $fail) {
                    if (DocumentUpload::categoryForType($value) === null) {
                        $fail("Invalid document type.");
                    }
                }],
                'file' => 'required|file|mimes:jpg,jpeg,png,webp,pdf|max:10240',
            ]);

            $type     = $request->input('type');
            $file     = $request->file('file');
            $category = DocumentUpload::categoryForType($type);
            $folder   = DocumentUpload::S3_FOLDERS[$category];

            // ✅ DELETE OLD FILE (SAFE)
            $existing = DocumentUpload::where('user_id', $userId)
                ->where('type', $type)
                ->first();

            if ($existing) {
                try {
                    Storage::disk('s3')->delete($existing->s3_path);
                } catch (\Throwable $e) {
                    Log::warning('S3 delete failed: ' . $e->getMessage());
                }

                $existing->delete();
            }

            // ✅ UPLOAD NEW FILE
            $s3Path = Storage::disk('s3')->putFile($folder, $file);

            $document = DocumentUpload::create([
                'user_id'           => $userId,
                'category'          => $category,
                'type'              => $type,
                'original_filename' => $file->getClientOriginalName(),
                'mime_type'         => $file->getMimeType(),
                'file_size'         => $file->getSize(),
                's3_path'           => $s3Path,
                'is_required'       => DocumentUpload::isTypeRequired($type),
            ]);

            return response()->json([
                'status'  => 'success',
                'message' => 'Document uploaded successfully.',
                'data'    => $this->format($document),
            ], 201);

        } catch (\Exception $e) {
            Log::error('Upload failed: ' . $e->getMessage());

            return response()->json([
                'status' => 'error',
                'message' => 'Upload failed: ' . $e->getMessage(),
            ], 500);
        }
    }

    // ── GET /api/documents/{id} ────────────────────────────────────────────────
    public function show(int $id): JsonResponse
    {
        $document = DocumentUpload::where('user_id', Auth::id())
            ->findOrFail($id);

        return response()->json([
            'status' => 'success',
            'data'   => $this->format($document),
        ]);
    }

    // ── DELETE /api/documents/{id} ─────────────────────────────────────────────
    public function destroy(int $id): JsonResponse
    {
        try {
            $userId = $this->getUserIdFromAuthToken();

            $document = DocumentUpload::where('user_id', $userId)
                ->findOrFail($id);

            try {
                Storage::disk('s3')->delete($document->s3_path);
            } catch (\Throwable $e) {
                Log::warning('S3 delete failed: ' . $e->getMessage());
            }

            $document->delete();

            return response()->json([
                'status'  => 'success',
                'message' => 'Document removed successfully.',
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    // ── POST /api/documents/submit ─────────────────────────────────────────────
    public function submit(): JsonResponse
    {
        $userId = Auth::id();

        if (!DocumentUpload::allRequiredUploaded($userId)) {
            $missing = [];

            foreach (DocumentUpload::SLOTS as $category => $slots) {
                foreach ($slots as $type => $meta) {
                    if (!$meta['required']) continue;

                    $exists = DocumentUpload::where('user_id', $userId)
                        ->where('type', $type)
                        ->exists();

                    if (!$exists) {
                        $missing[] = [
                            'category' => $category,
                            'type'     => $type,
                            'label'    => $meta['label'],
                        ];
                    }
                }
            }

            return response()->json([
                'status'  => 'error',
                'message' => 'Not all required documents have been uploaded.',
                'data'    => ['missing' => $missing],
            ], 422);
        }

        // ── Put your own submission logic here ──
        // e.g. $application->update(['status' => 'submitted']);

        return response()->json([
            'status'  => 'success',
            'message' => 'All required documents verified. Submission complete.',
        ]);
    }

    // ── Helper ─────────────────────────────────────────────────────────────────
    private function format(DocumentUpload $doc): array
    {
        return [
            'id'                => $doc->id,
            'category'          => $doc->category,
            'type'              => $doc->type,
            'label'             => DocumentUpload::labelForType($doc->type),
            'original_filename' => $doc->original_filename,
            'mime_type'         => $doc->mime_type,
            'file_size'         => $doc->file_size,
            'is_required'       => $doc->is_required,
            'url'               => $doc->url, // 15-min signed S3 URL
            'uploaded_at'       => $doc->created_at->toIso8601String(),
        ];
    }
}
