<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreBarangayBuildingClearanceRequest;
use App\Http\Requests\UpdateBarangayBuildingClearanceRequest;
use App\Models\BarangayBuildingClearance;
use App\Services\TicketService;
use App\Traits\ExtractsUserFromAuthToken;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use App\Models\Ticket;
use Illuminate\Support\Str;
use Carbon\Carbon;
use App\Models\ActivityLogger;
class BarangayBuildingClearanceController extends Controller
{
    use ExtractsUserFromAuthToken;
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        BarangayBuildingClearance::where('status', 'RELEASED')
            ->whereNotNull('expires_at')
            ->where('expires_at', '<=', Carbon::now())
            ->update(['status' => 'EXPIRED']);

        $query = BarangayBuildingClearance::with([
            'schedule:id,document_number,schedule_date,schedule_time'
        ]);

        // 🔍 Search
        if ($request->filled('search')) {
            $search = $request->search;

            $query->where(function ($q) use ($search) {
                $q->where('surname', 'like', "%{$search}%")
                ->orWhere('first_name', 'like', "%{$search}%")
                ->orWhere('middle_name', 'like', "%{$search}%")
                ->orWhere('bcert_number', 'like', "%{$search}%")
                ->orWhere('house_block_lot_no', 'like', "%{$search}%")
                ->orWhere('street', 'like', "%{$search}%")
                ->orWhere('zone', 'like', "%{$search}%")
                ->orWhere('purpose', 'like', "%{$search}%")
                ->orWhere('or_no', 'like', "%{$search}%")
                ->orWhere('remarks', 'like', "%{$search}%")
                ->orWhereRaw("CONCAT(first_name, ' ', surname) LIKE ?", ["%{$search}%"]);
            });
        }

        // 📍 Zone
        if ($request->filled('zone')) {
            $query->where('zone', $request->zone);
        }

        // 📍 Status
        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }

        // 📅 Predefined date filters
        if ($request->filled('filter_date')) {
            switch ($request->filter_date) {
                case 'this_week':
                    $query->whereBetween('created_at', [
                        now()->startOfWeek(),
                        now()->endOfWeek()
                    ]);
                    break;

                case 'this_month':
                    $query->whereMonth('created_at', now()->month)
                        ->whereYear('created_at', now()->year);
                    break;

                case 'this_year':
                    $query->whereYear('created_at', now()->year);
                    break;
            }
        }

        // 📅 Custom date range
        if ($request->filled('from') && $request->filled('to')) {
            $query->whereBetween('created_at', [
                $request->from . ' 00:00:00',
                $request->to . ' 23:59:59'
            ]);
        }

        // 📅 Schedule filter 🔥
        if ($request->filled('schedule_filter')) {

            if ($request->schedule_filter === 'has_schedule') {
                $query->has('schedule');
            }

            elseif ($request->schedule_filter === 'no_schedule') {
                $query->doesntHave('schedule');
            }

            else {
                // treat as date filter
                $query->whereHas('schedule', function ($q) use ($request) {
                    $q->where('schedule_date', $request->schedule_filter);
                });
            }
        }

        // 🔽 Sorting (SAFE)
        $sortField = Str::snake($request->get('sortField', 'created_at'));
        $sortDirection = $request->get('sortDirection', 'desc');

        $allowedSorts = [
            'created_at',
            'surname',
            'first_name',
            'status',
            'bcert_number',
            'zone'
        ];

        if (!in_array($sortField, $allowedSorts)) {
            $sortField = 'created_at';
        }

        $query->orderBy($sortField, $sortDirection);

        // 📄 Pagination
        $perPage = $request->get('pageSize', 15);

        $clearances = $query->paginate($perPage);

        return response()->json([
            'status' => 'success',
            'message' => 'Building clearances retrieved successfully',
            'data' => $clearances,
        ]);
    }

    public function chartData(Request $request)
    {
        $filter = $request->filter_date ?? 'this_month';
        $from = $request->from ?? null;
        $to = $request->to ?? null;
        
        $query = BarangayBuildingClearance::query();

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
        $data["status"] = "ENCODED";
        $data['created_by'] = $this->getUserIdFromAuthToken();
        $data['updated_by'] = $this->getUserIdFromAuthToken();

        $clearance = BarangayBuildingClearance::create($data);

        activity_log(
            'Building Clearance Created',
            'create',
            'Created #: ' . $clearance->bcert_number
        );

        // Find pending ticket for this service type and attach the created service
        $ticketQuery = \App\Models\Ticket::where('service_type', 'Building Clearance')->whereNull('serviceable_id');
        $found = null;
        $userId = $this->getUserIdFromAuthToken();
        if ($userId) {
            $found = (clone $ticketQuery)->where('requester_id', $userId)->orderBy('created_at', 'desc')->first();
        }
        if (!$found) {
            $found = $ticketQuery->orderBy('created_at', 'desc')->first();
        }
        if ($found) {
            $found->serviceable_type = \App\Models\BarangayBuildingClearance::class;
            $found->serviceable_id = $clearance->id;
            $found->status = 'ENCODED';
            $found->save();
        }

        $ticket = null;
        // try {
        //     $ticket = app(TicketService::class)->createTicketForService($clearance, 'Building Clearance', $data['priority'] ?? 'Normal', null);
        //     \Log::info('Ticket created for Building Clearance', ['ticket_id' => $ticket?->id]);
        // } catch (\Throwable $e) {
        //     \Log::error('Failed to create ticket for Building Clearance: ' . $e->getMessage());
        // }

        return response()->json([
            'status' => 'success',
            'message' => 'Building clearance created successfully',
            'data' => ['service' => $clearance, 'ticket' => $ticket],
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
    public function update(UpdateBarangayBuildingClearanceRequest $request, BarangayBuildingClearance $building_clearance)
    {
        \Log::info('Request data:', $request->validated());
        \Log::info('Model before update:', $building_clearance->toArray());
        
        $building_clearance->update($request->validated());

        activity_log(
            'Building Clearance Updated',
            'update',
            'Updated #: ' . $building_clearance->bcert_number
        );

        return response()->json([
            'status' => 'success',
            'message' => 'Building clearance updated successfully',
            'data' => $building_clearance->fresh(),
        ]);
    }

    public function updateStatusBuilding(Request $request, $id)
    {
        try {
            $validated = $request->validate([
                'status' => 'required|in:PENDING,ENCODED,INCOMPLETE,REJECTED,RELEASED, SCHEDULED, EXPIRED',
            ]);

            $record = BarangayBuildingClearance::findOrFail($id);

            // ✅ Set issued + expiry
            if ($validated['status'] === 'RELEASED' && !$record->issued_date) {
                $record->issued_date = now();
                $record->expires_at = now()->addMonths(12);
            }
            $record->status = $validated['status'];
            $record->save();

            activity_log(
                'Building Clearance Status Updated',
                'status_update',
                'Changed to ' . $validated['status'] . ' (#: ' . $record->bcert_number . ')'
            );

            return response()->json([
                "status" => "success",
                "message" => "Building clearance status updated",
                "data" => $record
            ]);

        } catch (\Exception $e) {
            return response()->json([
                "status" => "error",
                "message" => "Error updating building clearance: " . $e->getMessage(),
            ], 500);
        }
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(BarangayBuildingClearance $barangayBuildingClearance)
    {
        $barangayBuildingClearance->delete();

        activity_log(
            'Building Clearance Deleted',
            'delete',
            'Deleted #: ' . $deleted->bcert_number
        );

        return response()->json([
            'status' => 'success',
            'message' => 'Building clearance deleted successfully',
            'data' => null,
        ]);
    }
}

