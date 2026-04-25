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
        // Auto-expire documents
        BarangayBuildingClearance::where('status', 'RELEASED')
            ->whereNotNull('expires_at')
            ->where('expires_at', '<=', Carbon::now())
            ->update(['status' => 'EXPIRED']);

        $query = BarangayBuildingClearance::with([
            'schedule:id,document_number,schedule_date,schedule_time,user_id'
        ]);

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

        if ($request->filled('zone')) {
            $query->where('zone', $request->zone);
        }

        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }

        if ($request->filled('filter_date')) {
            switch ($request->filter_date) {
                case 'this_week':
                    $query->whereBetween('created_at', [now()->startOfWeek(), now()->endOfWeek()]);
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

        if ($request->filled('from') && $request->filled('to')) {
            $query->whereBetween('created_at', [
                $request->from . ' 00:00:00',
                $request->to   . ' 23:59:59',
            ]);
        }

        if ($request->filled('schedule_filter')) {
            if ($request->schedule_filter === 'has_schedule') {
                $query->has('schedule');
            } elseif ($request->schedule_filter === 'no_schedule') {
                $query->doesntHave('schedule');
            } else {
                $query->whereHas('schedule', function ($q) use ($request) {
                    $q->where('schedule_date', $request->schedule_filter);
                });
            }
        }

        $sortField     = Str::snake($request->get('sortField', 'created_at'));
        $sortDirection = $request->get('sortDirection', 'desc');
        $allowedSorts  = ['created_at', 'surname', 'first_name', 'status', 'bcert_number', 'zone'];

        if (! in_array($sortField, $allowedSorts)) {
            $sortField = 'created_at';
        }

        $query->orderBy($sortField, $sortDirection);

        $perPage    = $request->get('pageSize', 15);
        $clearances = $query->paginate($perPage);

        return response()->json([
            'status'  => 'success',
            'message' => 'Building clearances retrieved successfully',
            'data'    => $clearances,
        ]);
    }

    public function chartData(Request $request)
    {
        $filter = $request->filter_date ?? 'month';
        $from   = $request->from ?? null;
        $to     = $request->to   ?? null;

        $query = BarangayBuildingClearance::query();

        if ($from && $to) {
            $query->whereBetween('created_at', [$from . ' 00:00:00', $to . ' 23:59:59'])
                  ->selectRaw('DATE(created_at) as period, COUNT(*) as count')
                  ->groupBy('period')
                  ->orderBy('period');
        } else {
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

        return response()->json([
            'status' => 'success',
            'data'   => $query->get(),
        ]);
    }

    public function total(Request $request)
    {
        return response()->json([
            'status'  => 'success',
            'message' => 'Total building clearances retrieved successfully',
            'data'    => BarangayBuildingClearance::count(),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreBarangayBuildingClearanceRequest $request)
    {
        $lastClearance = BarangayBuildingClearance::latest('created_at')->first();
        $lastNumber    = $lastClearance ? intval(substr($lastClearance->bcert_number, 13)) : 0;
        $newRecord     = 'BBUILDINGCLE-' . str_pad($lastNumber + 1, 3, '0', STR_PAD_LEFT);

        $data                 = $request->validated();
        $data['bcert_number'] = $newRecord;
        $data['status']       = 'ENCODED';
        $data['created_by']   = $this->getUserIdFromAuthToken();
        $data['updated_by']   = $this->getUserIdFromAuthToken();

        $clearance = BarangayBuildingClearance::create($data);

        activity_log('Building Clearance Created', 'create', 'Created #: ' . $clearance->bcert_number);

        // FIX: Kiosk stores the field as `surname`, not `last_name`
        $kiosk = \App\Models\Kiosk::where('service_type', 'Building Clearance')
            ->whereRaw('LOWER(first_name) = ?', [strtolower($data['first_name'])])
            ->whereRaw('LOWER(surname)    = ?', [strtolower($data['surname'])])
            ->first();

        if ($kiosk) {
            Ticket::where('serviceable_type', 'App\\Models\\Kiosk')
                ->where('serviceable_id', $kiosk->id)
                ->whereIn('status', ['pending', 'waiting', 'Pending'])
                ->update(['status' => 'called']);
        }

        return response()->json([
            'status'  => 'success',
            'message' => 'Building clearance created successfully',
            'data'    => ['service' => $clearance, 'ticket' => null],
        ], 201);
    }

    public function latestRecord()
    {
        $lastClearance = BarangayBuildingClearance::latest('created_at')->first();
        $lastNumber    = $lastClearance ? intval(substr($lastClearance->bcert_number, 13)) : 0;
        $newRecord     = 'BBUILDINGCLE-' . str_pad($lastNumber + 1, 3, '0', STR_PAD_LEFT);

        $lastId = BarangayBuildingClearance::latest('id')->first();
        $sum    = intval($lastId->id) + 1;

        return response()->json([
            'status'  => 'success',
            'message' => 'Successfully get the latest',
            'data'    => [
                'nextRecord' => $newRecord,
                'nextId'     => $sum,
            ],
        ], 200);
    }

    /**
     * Display the specified resource.
     */
    public function show(BarangayBuildingClearance $barangayBuildingClearance)
    {
        return response()->json([
            'status'  => 'success',
            'message' => 'Building clearance retrieved successfully',
            'data'    => $barangayBuildingClearance,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateBarangayBuildingClearanceRequest $request, BarangayBuildingClearance $building_clearance)
    {
        $data = $request->validated();

        $building_clearance->update($data);

        activity_log(
            'Building Clearance Updated',
            'update',
            'Updated #: ' . $building_clearance->bcert_number
        );

        // ✅ Notify user about update
        $user = \App\Models\User::whereRaw('LOWER(first_name) = ?', [strtolower($building_clearance->first_name)])
            ->whereRaw('LOWER(surname) = ?', [strtolower($building_clearance->surname)])
            ->first();

        if ($user) {
            \App\Models\Notification::create([
                'user_id'      => $user->id,
                'title'        => 'Building Clearance Updated',
                'message'      => 'Your Building Clearance has been updated. (Ref #: ' . $building_clearance->bcert_number . ')',
                'type'         => 'building_clearance',
                'reference_id' => $building_clearance->id,
            ]);
        }

        return response()->json([
            'status'  => 'success',
            'message' => 'Building clearance updated successfully',
            'data'    => $building_clearance->fresh(),
        ]);
    }

    public function updateStatusBuilding(Request $request, $id)
    {
        $validated = $request->validate([
            'status' => 'required|in:PENDING,ENCODED,INCOMPLETE,REJECTED,RELEASED,SCHEDULED,EXPIRED,PAID,TO_PAY',
        ]);

        $record = BarangayBuildingClearance::findOrFail($id);

        $newStatus = strtoupper($validated['status']);

        // ✅ Handle PAID
        if ($newStatus === 'PAID') {
            $record->issued_date = now();
            $record->issued_at   = 'Barangay Hall';
        }

        // ✅ Handle RELEASED
        if ($newStatus === 'RELEASED') {
            $record->issued_date = $record->issued_date ?? now();
            $record->issued_at   = $record->issued_at ?? 'Barangay Hall';
            $record->expires_at  = now()->addMonths(12); // keep 12 months for building
        }

        // Status labels
        $statusLabels = [
            'PENDING'    => ['label' => 'Pending',    'message' => 'Your Building Clearance application is now pending review.'],
            'ENCODED'    => ['label' => 'Encoded',    'message' => 'Your Building Clearance application has been encoded.'],
            'INCOMPLETE' => ['label' => 'Incomplete', 'message' => 'Your Building Clearance application is incomplete.'],
            'REJECTED'   => ['label' => 'Rejected',   'message' => 'Your Building Clearance application was rejected.'],
            'RELEASED'   => ['label' => 'Released',   'message' => 'Your Building Clearance is ready for release.'],
            'SCHEDULED'  => ['label' => 'Scheduled',  'message' => 'Your Building Clearance has been scheduled.'],
            'EXPIRED'    => ['label' => 'Expired',    'message' => 'Your Building Clearance has expired.'],
            'PAID'       => ['label' => 'Paid',       'message' => 'Payment confirmed for your Building Clearance.'],
            'TO_PAY'     => ['label' => 'For Payment','message' => 'Your Building Clearance is ready for payment.'],
        ];

        $statusInfo = $statusLabels[$newStatus] ?? null;

        if ($statusInfo) {
            $user = \App\Models\User::whereRaw('LOWER(first_name) = ?', [strtolower($record->first_name ?? '')])
                ->whereRaw('LOWER(surname) = ?', [strtolower($record->surname ?? '')])
                ->first();

            if ($user) {
                \App\Models\Notification::create([
                    'user_id'      => $user->id,
                    'title'        => 'Building Clearance — ' . $statusInfo['label'],
                    'message'      => $statusInfo['message'] . ' (Ref #: ' . $record->bcert_number . ')',
                    'type'         => 'building_clearance',
                    'reference_id' => $record->id,
                ]);
            }
        }

        $record->status = $newStatus;
        $record->save();

        // Ticket mapping
        $ticketStatusMap = [
            'PENDING'  => 'pending',
            'ENCODED'  => 'called',
            'RELEASED' => 'released',
        ];

        $ticketStatus = $ticketStatusMap[$newStatus] ?? null;

        if ($ticketStatus) {
            $kiosk = \App\Models\Kiosk::where('service_type', 'Building Clearance')
                ->whereRaw('LOWER(first_name) = ?', [strtolower($record->first_name ?? '')])
                ->whereRaw('LOWER(surname) = ?', [strtolower($record->surname ?? '')])
                ->first();

            if ($kiosk) {
                Ticket::where('serviceable_type', 'App\\Models\\Kiosk')
                    ->where('serviceable_id', $kiosk->id)
                    ->update(['status' => $ticketStatus]);
            }
        }

        activity_log(
            'Building Clearance Status Updated',
            'status_update',
            'Changed to ' . $newStatus . ' (#: ' . $record->bcert_number . ')'
        );

        return response()->json([
            'status'  => 'success',
            'message' => 'Building clearance status updated',
            'data'    => $record,
        ], 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(BarangayBuildingClearance $barangayBuildingClearance)
    {
        $bcertNumber = $barangayBuildingClearance->bcert_number;
        $barangayBuildingClearance->delete();

        activity_log('Building Clearance Deleted', 'delete_document', 'Deleted #: ' . $bcertNumber);

        return response()->json([
            'status'  => 'success',
            'message' => 'Building clearance deleted successfully',
            'data'    => null,
        ]);
    }
}