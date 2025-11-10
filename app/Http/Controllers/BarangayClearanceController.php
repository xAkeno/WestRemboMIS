<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreBarangayClearanceRequest;
use App\Http\Requests\UpdateBarangayClearanceRequest;
use App\Models\BarangayClearance;
use Illuminate\Http\Request;

class BarangayClearanceController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = BarangayClearance::query();

        // Search functionality
        if ($request->has('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('surname', 'like', "%{$search}%")
                  ->orWhere('first_name', 'like', "%{$search}%")
                  ->orWhere('trans_number', 'like', "%{$search}%")
                  ->orWhere('bcert_number', 'like', "%{$search}%");
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
            'message' => 'Barangay clearances retrieved successfully',
            'data' => $clearances,
        ]);
    }
    public function total(Request $request){
        $total = BarangayClearance::count();

        return response()->json([
            'status' => 'success',
            'message' => 'Barangay clearances total retrieved successfully',
            'data' => $total,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreBarangayClearanceRequest $request)
    {
        $data = $request->validated();
        $clearance = BarangayClearance::create($data);

        return response()->json([
            'status' => 'success',
            'message' => 'Barangay clearance created successfully',
            'data' => $clearance,
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(BarangayClearance $barangayClearance)
    {
        return response()->json([
            'status' => 'success',
            'message' => 'Barangay clearance retrieved successfully',
            'data' => $barangayClearance,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateBarangayClearanceRequest $request, BarangayClearance $barangayClearance)
    {
        $data = $request->validated();
        $barangayClearance->update($data);

        return response()->json([
            'status' => 'success',
            'message' => 'Barangay clearance updated successfully',
            'data' => $barangayClearance->fresh(),
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(BarangayClearance $barangayClearance)
    {
        $barangayClearance->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Barangay clearance deleted successfully',
            'data' => null,
        ]);
    }
}

