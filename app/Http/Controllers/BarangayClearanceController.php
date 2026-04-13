<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreBarangayClearanceRequest;
use App\Http\Requests\UpdateBarangayClearanceRequest;
use App\Models\BarangayClearance;
use App\Services\TicketService;
use App\Traits\ExtractsUserFromAuthToken;
use Illuminate\Http\Request;
use App\Models\Ticket;
use Carbon\Carbon;
use App\Models\ActivityLogger;
class BarangayClearanceController extends Controller
{
    use ExtractsUserFromAuthToken;
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        // ✅ Auto-expire documents
        BarangayClearance::where('status', 'RELEASED')
            ->whereNotNull('expires_at')
            ->where('expires_at', '<=', Carbon::now())
            ->update(['status' => 'EXPIRED']);

        $query = BarangayClearance::with('schedule');

        // 🔍 Search
        if ($request->filled('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('surname', 'like', "%{$search}%")
                ->orWhere('first_name', 'like', "%{$search}%")
                ->orWhere('bcert_number', 'like', "%{$search}%");
            });
        }

        // 📍 Zone
        if ($request->filled('zone')) {
            $query->where('zone', $request->zone);
        }

        // 📍 Street
        if ($request->filled('street')) {
            $query->where('street', $request->street);
        }

        // 📍 Purpose
        if ($request->filled('purpose')) {
            $query->where('purpose', $request->purpose);
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

        // 📅 Schedule filter (example - adjust column if needed)
        if ($request->filled('schedule_filter')) {
            $query->whereHas('schedule', function ($q) use ($request) {
                $q->where('schedule_date', $request->schedule_filter);
                // OR use schedule_time depending on your filter
            });
        }

        // 🔽 Sorting
        $sortField = $request->get('sortField', 'created_at');
        $sortDirection = $request->get('sortDirection', 'desc');

        $allowedSorts = ['created_at', 'surname', 'first_name', 'status'];

        if (!in_array($sortField, $allowedSorts)) {
            $sortField = 'created_at';
        }

        $query->orderBy($sortField, $sortDirection);

        // 📄 Pagination (FIXED)
        $perPage = $request->get('pageSize', 15);

        $clearances = $query->paginate($perPage);

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
        $data['status'] = 'ENCODED';
        $data['created_by'] = $this->getUserIdFromAuthToken();
        $data['updated_by'] = $this->getUserIdFromAuthToken();

        $clearance = BarangayClearance::create($data);

        activity_log('Barangay Clearance Created', 'create', 'Created #: ' . $clearance->bcert_number);

        // Find the ticket linked to a Kiosk with matching service data
        // then move it from Pending → Processing
        Ticket::where('serviceable_type', 'App\\Models\\Kiosk')
            ->where('status', 'Pending')
            ->whereHas('serviceable', function ($q) use ($data) {
                $q->where('service_type', 'Barangay Clearance')
                ->where('first_name', $data['first_name'])
                ->where('last_name', $data['surname']);
            })
            ->update(['status' => 'Processing']);

        return response()->json([
            'status' => 'success',
            'message' => 'Barangay clearance created successfully',
            'data' => ['service' => $clearance, 'ticket' => null],
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

        activity_log(
            'Barangay Clearance Updated',
            'update',
            'Updated #: ' . $barangayClearance->bcert_number
        );

        return response()->json([
            'status' => 'success',
            'message' => 'Barangay clearance updated successfully',
            'data' => $barangayClearance->fresh(),
        ]);
    }

    public function updateStatusClearance(Request $request, $id)
    {
        $validated = $request->validate([
            'status' => 'required|in:PENDING,ENCODED,INCOMPLETE,REJECTED,RELEASED,SCHEDULED,EXPIRED,PAID',
        ]);

        $record = BarangayClearance::findOrFail($id);

        if ($validated['status'] === 'RELEASED') {
            $record->issued_date = $record->issued_date ?? now();
            $record->expires_at = now()->addMonths(6);
        }

        $record->status = strtoupper($validated['status']);
        $record->touch();
        $record->save();

        $ticketStatusMap = [
            'PENDING'  => 'Pending',
            'ENCODED'  => 'Processing',
            'RELEASED' => 'Released',   
        ];

        // Uppercase before map lookup so "released" and "RELEASED" both match
        $ticketStatus = $ticketStatusMap[strtoupper($validated['status'])] ?? null;

        if ($ticketStatus) {
            $kiosk = \App\Models\Kiosk::where('service_type', 'Barangay Clearance')
                ->whereRaw('LOWER(first_name) = ?', [strtolower($record->first_name)])
                ->whereRaw('LOWER(last_name) = ?', [strtolower($record->surname)])
                ->first();

            \Log::info('Kiosk lookup', [
                'first_name' => $record->first_name,
                'surname'    => $record->surname,
                'kiosk'      => $kiosk?->id,
            ]);

            if ($kiosk) {
                $updated = Ticket::where('serviceable_type', 'App\\Models\\Kiosk')
                    ->where('serviceable_id', $kiosk->id)
                    ->update(['status' => $ticketStatus]);

                \Log::info('Ticket rows updated', ['count' => $updated]);
            }
        }

        activity_log(
            'Barangay Clearance Status Updated',
            'status_update',
            'Changed to ' . $validated['status'] . ' (#: ' . $record->bcert_number . ')'
        );

        return response()->json([
            'status'  => 'success',
            'message' => 'Barangay clearance status updated',
            'data'    => $record,
        ], 200);
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(BarangayClearance $barangayClearance)
    {
        $barangayClearance->delete();

        activity_log(
            'Barangay Clearance Deleted',
            'delete',
            'Deleted #: ' . $deleted->bcert_number
        );

        return response()->json([
            'status' => 'success',
            'message' => 'Barangay clearance deleted successfully',
            'data' => null,
        ]);
    }
}

