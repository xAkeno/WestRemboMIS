<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Models\ReprintRequest;
use App\Traits\ExtractsUserFromAuthToken;
use Carbon\Carbon;

class ReprintRequestController extends Controller
{
    use ExtractsUserFromAuthToken;

    /*
    |--------------------------------------------------------------------------
    | 🟢 REQUEST REPRINT / HARDCOPY
    |--------------------------------------------------------------------------
    */
    public function requestReprint(Request $request): JsonResponse
    {
        $userId = $this->getUserIdFromAuthToken();

        $request->validate([
            'document_type'   => 'required|string',
            'document_number' => 'required|string',
            'reason'          => 'nullable|string|max:500',
        ]);

        $document = $this->findDocument(
            $request->document_type,
            $request->document_number
        );

        if (!$document) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Document not found.',
            ], 404);
        }

        /*
        |--------------------------------------------------------------------------
        | ✅ ONLY RELEASED DOCUMENTS
        |--------------------------------------------------------------------------
        */
        if (strtoupper($document->status ?? '') !== 'RELEASED') {
            return response()->json([
                'status'  => 'error',
                'message' => 'Only released documents can request reprint.',
            ], 422);
        }

        /*
        |--------------------------------------------------------------------------
        | ✅ CHECK EXPIRATION
        |--------------------------------------------------------------------------
        */
        if (
            isset($document->expires_at) &&
            $document->expires_at &&
            Carbon::parse($document->expires_at)->isPast()
        ) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Document is already expired.',
            ], 422);
        }

        /*
        |--------------------------------------------------------------------------
        | ✅ PREVENT DUPLICATE PENDING REQUEST
        |--------------------------------------------------------------------------
        */
        $existing = ReprintRequest::where('document_type', $request->document_type)
            ->where('document_number', $request->document_number)
            ->whereIn('status', ['PENDING', 'APPROVED'])
            ->first();

        if ($existing) {
            return response()->json([
                'status'  => 'error',
                'message' => 'A reprint request already exists.',
            ], 422);
        }

        $reprint = ReprintRequest::create([
            'user_id'         => $userId,
            'document_type'   => $request->document_type,
            'document_number' => $request->document_number,
            'reason'          => $request->reason,
            'status'          => 'PENDING',
        ]);

        return response()->json([
            'status'  => 'success',
            'message' => 'Reprint request submitted successfully.',
            'data'    => $reprint,
        ], 201);
    }

    /*
    |--------------------------------------------------------------------------
    | 🟢 FIND DOCUMENT
    |--------------------------------------------------------------------------
    */
    private function findDocument(string $documentType, string $documentNumber)
    {
        $map = [
            'barangay_clearance' => [
                \App\Models\BarangayClearance::class,
                'bcert_number'
            ],

            'barangay_certificate' => [
                \App\Models\BarangayCertificate::class,
                'bcert_number'
            ],

            'business_clearance' => [
                \App\Models\BarangayBusinessClearance::class,
                'brgy_business_no'
            ],

            'building_clearance' => [
                \App\Models\BarangayBuildingClearance::class,
                'bcert_number'
            ],
        ];

        if (!isset($map[$documentType])) {
            return null;
        }

        [$model, $column] = $map[$documentType];

        return $model::where($column, $documentNumber)->first();
    }
}