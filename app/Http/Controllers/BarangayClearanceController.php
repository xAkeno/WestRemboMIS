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
        if ($request->has('search') && $request->search !== null) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('surname', 'like', "%{$search}%")
                ->orWhere('first_name', 'like', "%{$search}%")
                ->orWhere('trans_number', 'like', "%{$search}%")
                ->orWhere('bcert_number', 'like', "%{$search}%");
            });
        }

        // Filter by zone
        if ($request->has('zone') && $request->zone !== null) {
            $query->where('zone', $request->zone);
        }

        // Filter by status (Pending, Released, etc.) - currently commented
        /*
        if ($request->has('status') && $request->status !== null && $request->status !== 'All') {
            $query->where('status', $request->status);
        }
        */

        // Filter by predefined periods: week, month, year
        if ($request->has('filter_date') && $request->filter_date !== null) {
            $filter = $request->filter_date;

            if ($filter === 'this_week') {
                $query->whereBetween('created_at', [
                    now()->startOfWeek(), // adjust start day if needed
                    now()->endOfWeek()
                ]);
            } elseif ($filter === 'this_month') {
                $query->whereMonth('created_at', now()->month)
                    ->whereYear('created_at', now()->year);
            } elseif ($filter === 'this_year') {
                $query->whereYear('created_at', now()->year);
            }
        }

        // Filter by custom date range
        if ($request->has('from') && $request->has('to') && $request->from !== null && $request->to !== null) {
            $query->whereBetween('created_at', [
                $request->from . ' 00:00:00',
                $request->to . ' 23:59:59'
            ]);
        }

        // Pagination
        $perPage = $request->get('per_page', 15);
        $clearances = $query->orderBy('created_at', 'desc')->paginate($perPage);

        return response()->json([
            'status' => 'success',
            'message' => 'Barangay clearances retrieved successfully',
            'data' => $clearances,
        ]);
    }

    public function chartData(Request $request)
    {
        $filter = $request->filter_date ?? 'month';
        $from = $request->from ?? null;
        $to = $request->to ?? null;
        
        $query = BarangayClearance::query();

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

        $lastResident = BarangayClearance::latest('created_at')->first();
        $lastNumber = $lastResident ? intval(substr($lastResident->bcert_number, 8)) : 0;
        $newRecord = 'BCLEAR-' . str_pad($lastNumber + 1, 3, '0', STR_PAD_LEFT);

        $data = $request->validated();

        $data['bcert_number'] = $newRecord;
        $data['status'] = "PENDING";


        // $data["created_by"] = auth()->id();
        $clearance = BarangayClearance::create($data);

        return response()->json([
            'status' => 'success',
            'message' => 'Barangay clearance created successfully',
            'data' => $clearance,
        ], 201);
    }
    public function latestRecord(){
        $lastResident = BarangayClearance::latest('created_at')->first();
        $lastNumber = $lastResident ? intval(substr($lastResident->bcert_number, 8)) : 0;
        $newRecord = 'BCLEAR-' . str_pad($lastNumber + 1, 3, '0', STR_PAD_LEFT);

        $lastId = BarangayClearance::latest('id')->first();
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

