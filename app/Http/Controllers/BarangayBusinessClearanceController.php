<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreBarangayBusinessClearanceRequest;
use App\Http\Requests\UpdateBarangayBusinessClearanceRequest;
use App\Models\BarangayBusinessClearance;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class BarangayBusinessClearanceController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = BarangayBusinessClearance::query();

        // Search functionality
        if ($request->has('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('surname', 'like', "%{$search}%")
                  ->orWhere('first_name', 'like', "%{$search}%")
                  ->orWhere('trans_number', 'like', "%{$search}%")
                  ->orWhere('bcert_number', 'like', "%{$search}%")
                  ->orWhere('business_name', 'like', "%{$search}%");
            });
        }

        // Filter by zone
        if ($request->has('zone')) {
            $query->where('zone', $request->zone);
        }

        $perPage = $request->get('per_page', 15);
        $clearances = $query->orderBy('created_at', 'desc')->paginate($perPage);

        return response()->json([
            'status' => 'success',
            'message' => 'Business clearances retrieved successfully',
            'data' => $clearances,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreBarangayBusinessClearanceRequest $request)
    {
        $data = $request->validated();

        // $data["created_by"] = auth()->id();

        // // Handle attachment upload
        // if ($request->hasFile('attachment')) {
        //     $attachment = $request->file('attachment');
        //     $attachmentPath = $attachment->store('clearances/business/attachments', 'public');
        //     $data['attachment'] = $attachmentPath;
        // }

        $clearance = BarangayBusinessClearance::create($data);

        return response()->json([
            'status' => 'success',
            'message' => 'Business clearance created successfully',
            'data' => $clearance,
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(BarangayBusinessClearance $barangayBusinessClearance)
    {
        return response()->json([
            'status' => 'success',
            'message' => 'Business clearance retrieved successfully',
            'data' => $barangayBusinessClearance,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateBarangayBusinessClearanceRequest $request, BarangayBusinessClearance $barangayBusinessClearance)
    {
        $data = $request->validated();

        // Handle attachment upload
        if ($request->hasFile('attachment')) {
            // Delete old attachment if exists
            if ($barangayBusinessClearance->attachment) {
                Storage::disk('public')->delete($barangayBusinessClearance->attachment);
            }
            $attachment = $request->file('attachment');
            $attachmentPath = $attachment->store('clearances/business/attachments', 'public');
            $data['attachment'] = $attachmentPath;
        }

        $barangayBusinessClearance->update($data);

        return response()->json([
            'status' => 'success',
            'message' => 'Business clearance updated successfully',
            'data' => $barangayBusinessClearance->fresh(),
        ]);
    }
    public function total(Request $request){
        $total = BarangayBusinessClearance::count();

        return response()->json([
            'status' => 'success',
            'message' => 'Business clearance total successfully',
            'data' => $total,
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(BarangayBusinessClearance $barangayBusinessClearance)
    {
        // Delete attachment if exists
        if ($barangayBusinessClearance->attachment) {
            Storage::disk('public')->delete($barangayBusinessClearance->attachment);
        }

        $barangayBusinessClearance->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Business clearance deleted successfully',
            'data' => null,
        ]);
    }
}

