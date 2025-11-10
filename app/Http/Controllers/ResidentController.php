<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreResidentRequest;
use App\Http\Requests\UpdateResidentRequest;
use App\Models\Resident;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class ResidentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = Resident::query();

        // Search functionality
        if ($request->has('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('surname', 'like', "%{$search}%")
                  ->orWhere('first_name', 'like', "%{$search}%")
                  ->orWhere('resident_id', 'like', "%{$search}%")
                  ->orWhere('zone', 'like', "%{$search}%");
            });
        }

        // Filter by zone
        if ($request->has('zone')) {
            $query->where('zone', $request->zone);
        }

        $perPage = $request->get('per_page', 15);
        $residents = $query->orderBy('created_at', 'desc')->paginate($perPage);

        return response()->json([
            'status' => 'success',
            'message' => 'Residents retrieved successfully',
            'data' => $residents,
        ]);
    }

    public function total(Request $request){

        $total = Resident::count();

        return response()->json([
            "status" => "success",
            "messege" => "Resident total retrieved successfully",
            "data" => $total
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreResidentRequest $request)
    {
        $data = $request->validated();

        // Handle photo upload
        if ($request->hasFile('photo')) {
            $photo = $request->file('photo');
            $photoPath = $photo->store('residents/photos', 'public');
            $data['photo'] = $photoPath;
        }

        $resident = Resident::create($data);

        return response()->json([
            'status' => 'success',
            'message' => 'Resident created successfully',
            'data' => $resident,
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Resident $resident)
    {
        return response()->json([
            'status' => 'success',
            'message' => 'Resident retrieved successfully',
            'data' => $resident,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateResidentRequest $request, Resident $resident)
    {
        $data = $request->validated();

        // Handle photo upload
        if ($request->hasFile('photo')) {
            // Delete old photo if exists
            if ($resident->photo) {
                Storage::disk('public')->delete($resident->photo);
            }
            $photo = $request->file('photo');
            $photoPath = $photo->store('residents/photos', 'public');
            $data['photo'] = $photoPath;
        }

        $resident->update($data);

        return response()->json([
            'status' => 'success',
            'message' => 'Resident updated successfully',
            'data' => $resident->fresh(),
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Resident $resident)
    {
        // Delete photo if exists
        if ($resident->photo) {
            Storage::disk('public')->delete($resident->photo);
        }

        $resident->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Resident deleted successfully',
            'data' => null,
        ]);
    }
}

