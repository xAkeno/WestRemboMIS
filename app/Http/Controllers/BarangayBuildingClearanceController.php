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
        $clearances = $query->orderBy('created_at', 'desc')->paginate($perPage);

        return response()->json([
            'status' => 'success',
            'message' => 'Building clearances retrieved successfully',
            'data' => $clearances,
        ]);
    }

    public function chartData(Request $request)
    {
        $filter = $request->filter_date ?? 'this_month';
        
        $query = BarangayBuildingClearance::query();

        if ($filter === 'this_week') {
            $query->whereBetween('created_at', [now()->startOfWeek(), now()->endOfWeek()])
                ->selectRaw('DAYNAME(created_at) as period, COUNT(*) as count')
                ->groupBy('period');
        } elseif ($filter === 'this_month') {
            $query->whereMonth('created_at', now()->month)
                ->whereYear('created_at', now()->year)
                ->selectRaw('DAY(created_at) as period, COUNT(*) as count')
                ->groupBy('period');
        } elseif ($filter === 'this_year') {
            $query->whereYear('created_at', now()->year)
                ->selectRaw('MONTHNAME(created_at) as period, COUNT(*) as count')
                ->groupBy('period');
        }

        // Custom from-to range
        if ($request->has('from') && $request->has('to')) {
            $query->whereBetween('created_at', [
                $request->from . ' 00:00:00',
                $request->to . ' 23:59:59'
            ])
            ->selectRaw('DATE(created_at) as period, COUNT(*) as count')
            ->groupBy('period');
        }

        $data = $query->get();

        return response()->json([
            'status' => 'success',
            'data' => $data
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

        // $date["created_by"] = auth()->id();
        $lastResident = BarangayBuildingClearance::latest('created_at')->first();
        $lastNumber = $lastResident ? intval(substr($lastResident->bcert_number, 13)) : 0;
        $newRecord = 'BBUILDINGCLE-' . str_pad($lastNumber + 1, 3, '0', STR_PAD_LEFT);

        $data['bcert_number'] = $newRecord;



        $clearance = BarangayBuildingClearance::create($data);

        return response()->json([
            'status' => 'success',
            'message' => 'Building clearance created successfully',
            'data' => $clearance,
        ], 201);
    }
    public function latestRecord(){
        $lastResident = BarangayBuildingClearance::latest('created_at')->first();
        $lastNumber = $lastResident ? intval(substr($lastResident->bcert_number, 14)) : 0;
        $newRecord = 'BBUILDINGCLE-' . str_pad($lastNumber + 1, 3, '0', STR_PAD_LEFT);

        $lastId = BarangayBuildingClearance::latest('id')->first();
        $lastNumber = intval($lastId->id);
        $sum = intval($lastNumber + 1);

        $data = [
            'nextRecord' => $newRecord,
            'nextId' => $sum,
        ];

        return response()->json([
            'status' => "success",
            'message' => "Successfully get the latest",
            'data' => $data,
        ],200);
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

