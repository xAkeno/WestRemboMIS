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
        try {
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

            // Filter by date
            if ($request->has('filter_date')) {
                $filter = $request->filter_date;

                if ($filter === 'this_week') {
                    $query->whereBetween('created_at', [
                        now()->startOfWeek(),
                        now()->endOfWeek()
                    ]);
                } elseif ($filter === 'this_month') {
                    $query->whereMonth('created_at', now()->month)
                        ->whereYear('created_at', now()->year);
                } elseif ($filter === 'this_year') {
                    $query->whereYear('created_at', now()->year);
                }
            }

            // Filter by from-to dates
            if ($request->has('from') && $request->has('to')) {
                $query->whereBetween('created_at', [
                    $request->from . ' 00:00:00',
                    $request->to . ' 23:59:59'
                ]);
            }

            // Filter by status (commented out for now)
            // if ($request->has('status')) {
            //     $query->where('status', $request->status);
            // }

            $perPage = $request->get('per_page', 15);
            $residents = $query->orderBy('created_at', 'desc')->paginate($perPage);

            return response()->json([
                'status' => 'success',
                'message' => 'Residents retrieved successfully',
                'data' => $residents,
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'An error occurred while getting Residents: ' . $e->getMessage(),
            ], 500);
        }
    }
public function chartData(Request $request)
{
    $filter = $request->filter_date ?? 'month';
    $from = $request->from ?? null;
    $to = $request->to ?? null;
    
    $query = Resident::query();

    // Custom from-to range
    if ($from && $to) {
        $query->whereBetween('created_at', [
            $from . ' 00:00:00',
            $to . ' 23:59:59'
        ])
        ->selectRaw('DATE(created_at) as period, COUNT(*) as count')
        ->groupBy('period')
        ->orderBy('period');
    } else {
        // Predefined filters
        if ($filter === 'week') {
            $query->whereBetween('created_at', [now()->startOfWeek(), now()->endOfWeek()])
                ->selectRaw('DAYOFWEEK(created_at) as day_num, DAYNAME(created_at) as period, COUNT(*) as count')
                ->groupBy('day_num', 'period')
                ->orderBy('day_num');
        } elseif ($filter === 'month') {
            $query->whereMonth('created_at', now()->month)
                ->whereYear('created_at', now()->year)
                ->selectRaw('DAY(created_at) as period, COUNT(*) as count')
                ->groupBy('period')
                ->orderBy('period');
        } elseif ($filter === 'year') {
            $query->whereYear('created_at', now()->year)
                ->selectRaw('MONTH(created_at) as month_num, MONTHNAME(created_at) as period, COUNT(*) as count')
                ->groupBy('month_num', 'period')
                ->orderBy('month_num');
        }
    }

    $data = $query->get();

    return response()->json([
        'status' => 'success',
        'data' => $data
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

        $lastResident = Resident::latest('created_at')->first();
        $lastNumber = $lastResident ? intval(substr($lastResident->resident_id, 4)) : 0;
        $data['resident_id'] = 'RES-' . str_pad($lastNumber + 1, 3, '0', STR_PAD_LEFT);
        $data['status'] = "PENDING";

        

        // Handle photo upload
        if ($request->hasFile('photo')) {
            $photo = $request->file('photo');
            $photoPath = $photo->store('residents/photos', 'public');
            $data['photo'] = $photoPath;
        }
        // $data["created_by"] = auth()->id();
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

