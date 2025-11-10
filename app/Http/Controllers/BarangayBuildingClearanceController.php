<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreBarangayBuildingClearanceRequest;
use App\Http\Requests\UpdateBarangayBuildingClearanceRequest;
use App\Models\BarangayBuildingClearance;
use Illuminate\Http\Request;

class BarangayBuildingClearanceController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = BarangayBuildingClearance::query();

        

        // Search functionality
        if ($request->has('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('surname', 'like', "%{$search}%")
                  ->orWhere('first_name', 'like', "%{$search}%")
                  ->orWhere('trans_number', 'like', "%{$search}%")
                  ->orWhere('bcert_number', 'like', "%{$search}%")
                  ->orWhere('establishment', 'like', "%{$search}%");
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
            'message' => 'Building clearances retrieved successfully',
            'data' => $clearances,
        ]);
    }
    
    // Get total number of building clearances
    public function total(Request $request){
        $total = BarangayBuildingClearance::count();

        return response()->json([
            "status" => "success",
            "message" => "Total building clearances retrieved successfully",
            "data" => $query,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreBarangayBuildingClearanceRequest $request)
    {
        $data = $request->validated();
        $clearance = BarangayBuildingClearance::create($data);

        return response()->json([
            'status' => 'success',
            'message' => 'Building clearance created successfully',
            'data' => $clearance,
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(BarangayBuildingClearance $barangayBuildingClearance)
    {
        return response()->json([
            'status' => 'success',
            'message' => 'Building clearance retrieved successfully',
            'data' => $barangayBuildingClearance,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateBarangayBuildingClearanceRequest $request, BarangayBuildingClearance $barangayBuildingClearance)
    {
        $data = $request->validated();
        $barangayBuildingClearance->update($data);

        return response()->json([
            'status' => 'success',
            'message' => 'Building clearance updated successfully',
            'data' => $barangayBuildingClearance->fresh(),
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(BarangayBuildingClearance $barangayBuildingClearance)
    {
        $barangayBuildingClearance->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Building clearance deleted successfully',
            'data' => null,
        ]);
    }
}

