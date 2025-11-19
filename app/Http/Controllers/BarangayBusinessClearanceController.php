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
            'message' => 'Business clearances retrieved successfully',
            'data' => $clearances,
        ]);
    }

    public function chartData(Request $request)
    {
        $filter = $request->filter_date ?? 'this_month';
        $from = $request->from ?? null;
        $to = $request->to ?? null;
        
        $query = BarangayBusinessClearance::query();

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
        $lastResident = BarangayBusinessClearance::latest('created_at')->first();
        $lastNumber = $lastResident ? intval(substr($lastResident->brgyBusinessNo, 11)) : 0;
        $newRecord = 'BBUSINESS-' . str_pad($lastNumber + 1, 3, '0', STR_PAD_LEFT);

        $data = $request->validated();

        $data['brgyBusinessNo'] = $newRecord;
        $data['status'] = "PENDING";


        $clearance = BarangayBusinessClearance::create($data);

        return response()->json([
            'status' => 'success',
            'message' => 'Business clearance created successfully',
            'data' => $clearance,
        ], 201);
    }
    public function latestRecord(){
        $lastResident = BarangayBusinessClearance::latest('created_at')->first();
        $lastNumber = $lastResident ? intval(substr($lastResident->brgyBusinessNo, 11)) : 0;
        $newRecord = 'BBUSINESS-' . str_pad($lastNumber + 1, 3, '0', STR_PAD_LEFT);

        $lastId = BarangayBusinessClearance::latest('id')->first();
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

    // Map frontend keys to database/model fields
    $data['businessName'] = $data['establishment'] ?? $data['businessName'] ?? null;
    $data['houseBlockLotNo'] = $data['houseBlockLot'] ?? $data['houseBlockLotNo'] ?? null;
    $data['ext'] = $data['extension'] ?? $data['ext'] ?? null;

    // Format dates to 'Y-m-d' for MySQL DATE
    foreach (['issuedDate', 'dateOfInspection', 'dateInspected'] as $dateField) {
        if (isset($data[$dateField]) && $data[$dateField]) {
            $data[$dateField] = date('Y-m-d', strtotime($data[$dateField]));
        }
    }

    // Handle attachment upload
    if ($request->hasFile('attachment')) {
        if ($barangayBusinessClearance->attachment) {
            Storage::disk('public')->delete($barangayBusinessClearance->attachment);
        }
        $attachment = $request->file('attachment');
        $data['attachment'] = $attachment->store('clearances/business/attachments', 'public');
    }

    // Update only fillable fields
    $fillable = $barangayBusinessClearance->getFillable();
    $updateData = array_intersect_key($data, array_flip($fillable));

    $barangayBusinessClearance->update($updateData);

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

