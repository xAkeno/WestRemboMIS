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
    | 🟢 GET ALL REPRINT REQUESTS
    |--------------------------------------------------------------------------
    */
    public function index(Request $request): JsonResponse
    {
        $userId = $this->getUserIdFromAuthToken();

        $query = ReprintRequest::query()->where('user_id', $userId);

        if ($request->document_type) {
            $query->where('document_type', $request->document_type);
        }

        return response()->json([
            'status' => 'success',
            'data' => $query->latest()->get()
        ]);
    }

    /*
    |--------------------------------------------------------------------------
    | 🟢 GET SINGLE REQUEST
    |--------------------------------------------------------------------------
    */
    public function show(string $id): JsonResponse
    {
        $userId = $this->getUserIdFromAuthToken();

        $request = ReprintRequest::where('id', $id)
            ->where('user_id', $userId)
            ->first();

        if (!$request) {
            return response()->json([
                'status' => 'error',
                'message' => 'Request not found.'
            ], 404);
        }

        return response()->json([
            'status' => 'success',
            'data' => $request
        ]);
    }

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

        if (strtoupper($document->status ?? '') !== 'RELEASED') {
            return response()->json([
                'status'  => 'error',
                'message' => 'Only released documents can request reprint.',
            ], 422);
        }

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
    | 🟡 APPROVE
    |--------------------------------------------------------------------------
    */
    public function approve(string $id): JsonResponse
    {
        $request = ReprintRequest::find($id);

        if (!$request) {
            return response()->json(['status' => 'error'], 404);
        }

        $request->update(['status' => 'APPROVED']);

        return response()->json([
            'status' => 'success',
            'message' => 'Reprint request approved.'
        ]);
    }

    /*
    |--------------------------------------------------------------------------
    | 🔴 REJECT
    |--------------------------------------------------------------------------
    */
    public function reject(string $id): JsonResponse
    {
        $request = ReprintRequest::find($id);

        if (!$request) {
            return response()->json(['status' => 'error'], 404);
        }

        $request->update(['status' => 'REJECTED']);

        return response()->json([
            'status' => 'success',
            'message' => 'Reprint request rejected.'
        ]);
    }

    /*
    |--------------------------------------------------------------------------
    | 🟣 PRINTED
    |--------------------------------------------------------------------------
    */
    public function markPrinted(string $id): JsonResponse
    {
        $request = ReprintRequest::find($id);

        if (!$request) {
            return response()->json(['status' => 'error'], 404);
        }

        $request->update(['status' => 'PRINTED']);

        return response()->json([
            'status' => 'success',
            'message' => 'Marked as printed.'
        ]);
    }

    /*
    |--------------------------------------------------------------------------
    | 🟢 CLAIMED
    |--------------------------------------------------------------------------
    */
    public function markClaimed(string $id): JsonResponse
    {
        $request = ReprintRequest::find($id);

        if (!$request) {
            return response()->json(['status' => 'error'], 404);
        }

        $request->update(['status' => 'CLAIMED']);

        return response()->json([
            'status' => 'success',
            'message' => 'Marked as claimed.'
        ]);
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