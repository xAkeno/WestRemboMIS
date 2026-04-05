<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreBarangayBusinessClearanceRequest;
use App\Http\Requests\UpdateBarangayBusinessClearanceRequest;
use App\Models\BarangayBusinessClearance;
use App\Services\TicketService;
use App\Traits\ExtractsUserFromAuthToken;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use App\Models\Ticket;
use Illuminate\Support\Facades\Log;
use Carbon\Carbon;
class BarangayBusinessClearanceController extends Controller
{
    use ExtractsUserFromAuthToken;
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        // ✅ Auto-expire
        BarangayBusinessClearance::where('status', 'RELEASED')
            ->whereNotNull('expires_at')
            ->where('expires_at', '<=', Carbon::now())
            ->update(['status' => 'EXPIRED']);
        $query = BarangayBusinessClearance::with([
            'schedule:id,document_number,schedule_date,schedule_time'
        ]);

        // 🔍 Search
        if ($request->filled('search')) {
            $search = $request->search;

            $query->where(function ($q) use ($search) {
                $q->where('surname', 'like', "%{$search}%")
                ->orWhere('first_name', 'like', "%{$search}%")
                ->orWhere('middle_name', 'like', "%{$search}%")
                ->orWhere('brgy_business_no', 'like', "%{$search}%")
                ->orWhere('business_name', 'like', "%{$search}%")
                ->orWhere('business_type', 'like', "%{$search}%")
                ->orWhere('capital', 'like', "%{$search}%")
                ->orWhere('street', 'like', "%{$search}%")
                ->orWhere('zone', 'like', "%{$search}%")
                ->orWhere('inspected_by', 'like', "%{$search}%")
                ->orWhere('inspection_remarks', 'like', "%{$search}%")
                ->orWhere('inspected_remarks', 'like', "%{$search}%")
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

        // 📅 Schedule filter (IMPORTANT 🔥)
        if ($request->filled('schedule_filter')) {
            $query->whereHas('schedule', function ($q) use ($request) {
                $q->where('schedule_date', $request->schedule_filter);
                // OR change to schedule_time depending on your UI
            });
        }

        // 🔽 Sorting
        $sortField = $request->get('sortField', 'created_at');
        $sortDirection = $request->get('sortDirection', 'desc');

        $allowedSorts = [
            'created_at',
            'surname',
            'first_name',
            'business_name',
            'status'
        ];

        if (!in_array($sortField, $allowedSorts)) {
            $sortField = 'created_at';
        }

        $query->orderBy($sortField, $sortDirection);

        // 📄 Pagination (FIXED to match frontend)
        $perPage = $request->get('pageSize', 15);

        $clearances = $query->paginate($perPage);

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
        $lastNumber = $lastResident ? intval(substr($lastResident->brgy_business_no, 11)) : 0;
        $newRecord = 'BBUSINESS-' . str_pad($lastNumber + 1, 3, '0', STR_PAD_LEFT);

        $data = $request->validated();

        $data['brgy_business_no'] = $newRecord;
        $data["status"] = "ENCODED";
        $data['created_by'] = $this->getUserIdFromAuthToken();
        $data['updated_by'] = $this->getUserIdFromAuthToken();


        $clearance = BarangayBusinessClearance::create($data);

        // Find pending ticket for this service type and attach the created service
        $ticketQuery = \App\Models\Ticket::where('service_type', 'Business Clearance')->whereNull('serviceable_id');
        $found = null;
        $userId = $this->getUserIdFromAuthToken();
        if ($userId) {
            $found = (clone $ticketQuery)->where('requester_id', $userId)->orderBy('created_at', 'desc')->first();
        }
        if (!$found) {
            $found = $ticketQuery->orderBy('created_at', 'desc')->first();
        }
        if ($found) {
            $found->serviceable_type = \App\Models\BarangayBusinessClearance::class;
            $found->serviceable_id = $clearance->id;
            $found->status = 'ENCODED';
            $found->save();
        }

        // Create ticket linked to this clearance (kiosk flow: no requester)
        $ticket = null;
        // try {
        //     $ticket = app(TicketService::class)->createTicketForService($clearance, 'Business Clearance', $data['priority'] ?? 'Normal', null);
        //     \Log::info('Ticket created for Business Clearance', ['ticket_id' => $ticket?->id, 'ticket_number' => $ticket?->ticket_number]);
        // } catch (\Throwable $e) {
        //     \Log::error('Failed to create ticket for Business Clearance: ' . $e->getMessage(), ['trace' => $e->getTraceAsString()]);
        // }

        return response()->json([
            'status' => 'success',
            'message' => 'Business clearance created successfully',
            'data' => [
                'service' => $clearance,
                'ticket' => $ticket,
            ],
        ], 201);
    }
    public function latestRecord(){
        $lastResident = BarangayBusinessClearance::latest('created_at')->first();
        $lastNumber = $lastResident ? intval(substr($lastResident->brgy_business_no, 11)) : 0;
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
    public function update(UpdateBarangayBusinessClearanceRequest $request, $id)
    {
        $barangayBusinessClearance = BarangayBusinessClearance::findOrFail($id);

        \Log::info('Route ID:', ['id' => $id]);
        \Log::info('Found Record:', $barangayBusinessClearance->toArray());

        $data = $request->validated();

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

    public function updateStatusBusiness(Request $request, $id)
    {
        try {
            $validated = $request->validate([
                'status' => 'required|in:PENDING,ENCODED,INCOMPLETE,REJECTED,RELEASED'
            ]);

            $record = BarangayBusinessClearance::findOrFail($id);

            // ✅ Set issued + expiry
            if ($validated['status'] === 'RELEASED' && !$record->issued_date) {
                $record->issued_date = now();
                $record->expires_at = now()->addYear(); // 🔥 business = 1 year (optional)
            }
            $record->status = $validated['status'];
            $record->save();

            return response()->json([
                "status" => "success",
                "message" => "Business clearance status updated",
                "data" => $record
            ]);

        } catch (\Exception $e) {
            return response()->json([
                "status" => "error",
                "message" => "Error updating business clearance: " . $e->getMessage(),
            ], 500);
        }
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

