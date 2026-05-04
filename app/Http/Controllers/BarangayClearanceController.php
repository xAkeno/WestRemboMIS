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
use Illuminate\Support\Facades\DB;
class BarangayClearanceController extends Controller
{
    use ExtractsUserFromAuthToken;

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        // Auto-expire documents
        BarangayClearance::where('status', 'RELEASED')
            ->whereNotNull('expires_at')
            ->where('expires_at', '<=', Carbon::now())
            ->update(['status' => 'EXPIRED']);

        $query = BarangayClearance::with('schedule');

        if ($request->filled('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('surname', 'like', "%{$search}%")
                  ->orWhere('first_name', 'like', "%{$search}%")
                  ->orWhere('bcert_number', 'like', "%{$search}%");
            });
        }

        if ($request->filled('zone')) {
            $query->where('zone', $request->zone);
        }

        if ($request->filled('street')) {
            $query->where('street', $request->street);
        }

        if ($request->filled('purpose')) {
            $query->where('purpose', $request->purpose);
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
            $query->whereHas('schedule', function ($q) use ($request) {
                $q->where('schedule_date', $request->schedule_filter);
            });
        }

        $sortField     = $request->get('sortField', 'created_at');
        $sortDirection = $request->get('sortDirection', 'desc');
        $allowedSorts  = ['created_at', 'surname', 'first_name', 'status'];

        if (! in_array($sortField, $allowedSorts)) {
            $sortField = 'created_at';
        }

        $query->orderBy($sortField, $sortDirection);

        $perPage    = $request->get('pageSize', 15);
        $clearances = $query->paginate($perPage);

        return response()->json([
            'status'  => 'success',
            'message' => 'Barangay clearances retrieved successfully',
            'data'    => $clearances,
        ]);
    }

    public function chartData(Request $request)
    {
        $filter = $request->filter_date ?? 'month';
        $from   = $request->from ?? null;
        $to     = $request->to   ?? null;
 
        $query = BarangayClearance::query();
 
        if ($from && $to) {
        // ✅ FIXED: Use EXTRACT(DAY...) for PostgreSQL compatibility
        $query->whereBetween('created_at', [$from . ' 00:00:00', $to . ' 23:59:59'])
              ->selectRaw("
                  EXTRACT(DAY FROM created_at)::int as period, 
                  TO_CHAR(created_at, 'YYYY-MM-DD') as full_date,
                  COUNT(*) as count
              ")
              ->groupBy('period', 'full_date')
              ->orderBy('period');
    } else {
        if ($filter === 'week') {
            // Group by ISO day-of-week (1 = Monday … 7 = Sunday)
            $query->whereBetween('created_at', [now()->startOfWeek(), now()->endOfWeek()])
                  ->selectRaw(
                      "EXTRACT(ISODOW FROM created_at)::int AS day_num, " .
                      "TO_CHAR(created_at, 'Dy') AS period, "             .
                      "COUNT(*) AS count"
                  )
                  ->groupBy('day_num', 'period')
                  ->orderBy('day_num');

        } elseif ($filter === 'month') {
            // Group by day-of-month number (1–31)
            $query->whereMonth('created_at', now()->month)
                  ->whereYear('created_at', now()->year)
                  ->selectRaw(
                      "EXTRACT(DAY FROM created_at)::int AS period, COUNT(*) AS count"
                  )
                  ->groupBy('period')
                  ->orderBy('period');

        } elseif ($filter === 'year') {
            // Group by month number, expose month name as the chart label
            $query->whereYear('created_at', now()->year)
                  ->selectRaw(
                      "EXTRACT(MONTH FROM created_at)::int AS month_num, " .
                      "TO_CHAR(created_at, 'Mon') AS period, "             .
                      "COUNT(*) AS count"
                  )
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
            'message' => 'Barangay clearances total retrieved successfully',
            'data'    => BarangayClearance::count(),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreBarangayClearanceRequest $request)
    {
        DB::beginTransaction();

        try {
            // ✅ Step 1: Lock rows FIRST (no aggregate)
            DB::table('barangay_clearances')
                ->select('id')
                ->orderByDesc('id')
                ->limit(1)
                ->lockForUpdate()
                ->get();

            // ✅ Step 2: Get MAX safely
            $lastNumber = DB::table('barangay_clearances')
                ->selectRaw("
                    COALESCE(
                        MAX(CAST(SUBSTRING(bcert_number FROM '[0-9]+$') AS INTEGER)),
                        0
                    ) as max_num
                ")
                ->value('max_num');

            $nextNumber = $lastNumber + 1;

            $newRecord = 'BCLEAR-' . str_pad($nextNumber, 3, '0', STR_PAD_LEFT);

            // ✅ Your original logic
            $data                 = $request->validated();
            $data['bcert_number'] = $newRecord;
            $data['status']       = 'ENCODED';
            $data['created_by']   = $this->getUserIdFromAuthToken();
            $data['updated_by']   = $this->getUserIdFromAuthToken();

            $clearance = BarangayClearance::create($data);

            activity_log(
                'Barangay Clearance Created',
                'create',
                'Created #: ' . $clearance->bcert_number
            );

            // ✅ Kiosk matching (unchanged)
            $kiosk = \App\Models\Kiosk::where('service_type', 'Barangay Clearance')
                ->whereRaw('LOWER(first_name) = ?', [strtolower($data['first_name'])])
                ->whereRaw('LOWER(surname)    = ?', [strtolower($data['surname'])])
                ->first();

            if ($kiosk) {
                Ticket::where('serviceable_type', 'App\\Models\\Kiosk')
                    ->where('serviceable_id', $kiosk->id)
                    ->whereIn('status', ['pending', 'waiting', 'Pending'])
                    ->update(['status' => 'called']);
            }

            DB::commit();

            return response()->json([
                'status'  => 'success',
                'message' => 'Barangay clearance created successfully',
                'data'    => [
                    'service' => $clearance,
                    'ticket'  => null
                ],
            ], 201);

        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function latestRecord()
    {
        $lastClearance = BarangayClearance::latest('created_at')->first();
        $lastNumber    = $lastClearance ? intval(substr($lastClearance->bcert_number, 8)) : 0;
        $newRecord     = 'BCLEAR-' . str_pad($lastNumber + 1, 3, '0', STR_PAD_LEFT);

        $lastId = BarangayClearance::latest('id')->first();
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
    public function show(BarangayClearance $barangayClearance)
    {
        return response()->json([
            'status'  => 'success',
            'message' => 'Barangay clearance retrieved successfully',
            'data'    => $barangayClearance,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateBarangayClearanceRequest $request, BarangayClearance $barangayClearance)
    {
        $data = $request->validated();

        $barangayClearance->update($data);

        // ✅ Only trigger if status actually changed
        if ($barangayClearance->wasChanged('status')) {

            $status = strtoupper($barangayClearance->status);

            $statusLabels = [
                'PENDING'    => ['label' => 'Pending',    'message' => 'Your Barangay Clearance application is now pending review.'],
                'ENCODED'    => ['label' => 'Encoded',    'message' => 'Your Barangay Clearance application has been encoded into the system.'],
                'INCOMPLETE' => ['label' => 'Incomplete', 'message' => 'Your Barangay Clearance application is incomplete. Please submit the missing requirements.'],
                'REJECTED'   => ['label' => 'Rejected',   'message' => 'Your Barangay Clearance application has been rejected. Please visit the barangay for more details.'],
                'RELEASED'   => ['label' => 'Released',   'message' => 'Your Barangay Clearance is ready for release. Please claim it at the barangay office.'],
                'SCHEDULED'  => ['label' => 'Scheduled',  'message' => 'Your Barangay Clearance has been scheduled. Please check your appointment details.'],
                'EXPIRED'    => ['label' => 'Expired',    'message' => 'Your Barangay Clearance has expired. Please apply for a renewal.'],
                'PAID'       => ['label' => 'Paid',       'message' => 'Payment for your Barangay Clearance has been confirmed.'],
                'TO_PAY'     => ['label' => 'For Payment','message' => 'Your Barangay Clearance is ready for payment. Please proceed to the cashier.'],
                'INSPECTING' => ['label' => 'Inspecting', 'message' => 'Your Barangay Clearance is currently being inspected.'],
            ];

            $statusInfo = $statusLabels[$status] ?? null;

            if ($statusInfo) {

                $user = \App\Models\User::whereRaw(
                        'LOWER(first_name) = ?',
                        [strtolower($barangayClearance->first_name)]
                    )
                    ->whereRaw(
                        'LOWER(surname) = ?',
                        [strtolower($barangayClearance->surname)]
                    )
                    ->first();

                if ($user) {
                    \App\Models\Notification::create([
                        'user_id'      => $user->id,
                        'title'        => 'Barangay Clearance — ' . $statusInfo['label'],
                        'message'      => $statusInfo['message'] . ' (Ref #: ' . $barangayClearance->bcert_number . ')',
                        'type'         => 'clearance',
                        'reference_id' => $barangayClearance->id,
                    ]);
                }
            }
        }

        activity_log(
            'Barangay Clearance Updated',
            'update',
            'Updated #: ' . $barangayClearance->bcert_number
        );

        return response()->json([
            'status'  => 'success',
            'message' => 'Barangay clearance updated successfully',
            'data'    => $barangayClearance->fresh(),
        ]);
    }

    public function updateStatusClearance(Request $request, $id)
    {
        $validated = $request->validate([
            'status' => 'required|in:PENDING,ENCODED,INCOMPLETE,REJECTED,RELEASED,SCHEDULED,EXPIRED,PAID,TO_PAY,INSPECTING,DISABLED'
        ]);

        $record = BarangayClearance::findOrFail($id);

        $status = strtoupper($validated['status']);

        if ($status === 'PAID') {
            $record->issued_date = now();
            $record->issued_at   = 'Barangay Hall';
            $record->issued_on   = now();  // ✅ ADD THIS
        }

        if ($status === 'RELEASED') {
            $record->issued_date = $record->issued_date ?? now();
            $record->issued_at   = $record->issued_at ?? 'Barangay Hall';
            $record->issued_on   = $record->issued_on ?? now();  // ✅ ADD THIS
            $record->expires_at  = now()->addMonths(6);
        }

        $statusLabels = [
            'PENDING'    => ['label' => 'Pending',    'message' => 'Your Barangay Clearance application is now pending review.'],
            'ENCODED'    => ['label' => 'Encoded',    'message' => 'Your Barangay Clearance application has been encoded into the system.'],
            'INCOMPLETE' => ['label' => 'Incomplete', 'message' => 'Your Barangay Clearance application is incomplete. Please submit the missing requirements.'],
            'REJECTED'   => ['label' => 'Rejected',   'message' => 'Your Barangay Clearance application has been rejected. Please visit the barangay for more details.'],
            'RELEASED'   => ['label' => 'Released',   'message' => 'Your Barangay Clearance is ready for release. Please claim it at the barangay office.'],
            'SCHEDULED'  => ['label' => 'Scheduled',  'message' => 'Your Barangay Clearance has been scheduled. Please check your appointment details.'],
            'EXPIRED'    => ['label' => 'Expired',    'message' => 'Your Barangay Clearance has expired. Please apply for a renewal.'],
            'PAID'       => ['label' => 'Paid',       'message' => 'Payment for your Barangay Clearance has been confirmed.'],
            'TO_PAY'     => ['label' => 'For Payment','message' => 'Your Barangay Clearance is ready for payment. Please proceed to the cashier.'],
            'INSPECTING' => ['label' => 'Inspecting', 'message' => 'Your Barangay Clearance is currently being inspected.'],
            'DISABLED'   => ['label' => 'Disabled',   'message' => 'Your Barangay Clearance has been disabled.'],
        ];

        $statusInfo = $statusLabels[strtoupper($validated['status'])] ?? null;

        if ($statusInfo) {

            $user = \App\Models\User::whereRaw(
                    'LOWER(first_name) = ?',
                    [strtolower($record->first_name)]
                )
                ->whereRaw(
                    'LOWER(surname) = ?',
                    [strtolower($record->surname)]
                )
                ->first();

            if ($user) {
                \App\Models\Notification::create([
                    'user_id'      => $user->id,
                    'title'        => 'Barangay Clearance — ' . $statusInfo['label'],
                    'message'      => $statusInfo['message'] . ' (Ref #: ' . $record->bcert_number . ')',
                    'type'         => 'clearance',
                    'reference_id' => $record->id,
                ]);
            }
        }

        $record->status = strtoupper($validated['status']);
        $record->save();

        $ticketStatusMap = [
            'PENDING'  => 'pending',
            'ENCODED'  => 'called',
            'RELEASED' => 'released',
            'DISABLED' => 'disabled',
        ];

        $ticketStatus = $ticketStatusMap[strtoupper($validated['status'])] ?? null;

        if ($ticketStatus) {

            $kiosk = \App\Models\Kiosk::where('service_type', 'Barangay Clearance')
                ->whereRaw('LOWER(first_name) = ?', [strtolower($record->first_name)])
                ->whereRaw('LOWER(surname) = ?', [strtolower($record->surname)])
                ->first();

            if ($kiosk) {
                Ticket::where('serviceable_type', 'App\\Models\\Kiosk')
                    ->where('serviceable_id', $kiosk->id)
                    ->update(['status' => $ticketStatus]);
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
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(BarangayClearance $barangayClearance)
    {
        $bcertNumber = $barangayClearance->bcert_number;
        $barangayClearance->delete();

        activity_log('Barangay Clearance Deleted', 'delete_document', 'Deleted #: ' . $bcertNumber);

        return response()->json([
            'status'  => 'success',
            'message' => 'Barangay clearance deleted successfully',
            'data'    => null,
        ]);
    }
    public function setDisposition(Request $request, $id)
    {
        $validated = $request->validate([
            'status' => 'required|in:REJECTED,INCOMPLETE',
            'reason' => 'required|string|max:1000',
        ]);

        $record = BarangayClearance::findOrFail($id);

        $oldStatus = strtoupper($record->status);
        $newStatus = strtoupper($validated['status']);

        // update status + reason
        $record->status = $newStatus;
        $record->rejection_reason = $validated['reason'];
        $record->save();

        $statusLabels = [
            'REJECTED' => [
                'label' => 'Rejected',
                'message' => 'Your Barangay Clearance application was rejected.'
            ],
            'INCOMPLETE' => [
                'label' => 'Incomplete',
                'message' => 'Your Barangay Clearance application is incomplete.'
            ],
        ];

        $statusInfo = $statusLabels[$newStatus] ?? null;

        // notify user
        if ($statusInfo) {

            $user = \App\Models\User::whereRaw(
                    'LOWER(first_name) = ?', [strtolower($record->first_name ?? '')]
                )
                ->whereRaw(
                    'LOWER(surname) = ?', [strtolower($record->surname ?? '')]
                )
                ->first();

            if ($user) {
                \App\Models\Notification::create([
                    'user_id'      => $user->id,
                    'title'        => 'Barangay Clearance — ' . $statusInfo['label'],
                    'message'      =>
                        $statusInfo['message'] .
                        ' Reason: ' . $validated['reason'] .
                        ' (Ref #: ' . $record->bcert_number . ')',
                    'type'         => 'clearance',
                    'reference_id' => $record->id,
                ]);
            }
        }

        return response()->json([
            'status'  => 'success',
            'message' => "Barangay Clearance marked as {$newStatus}",
            'data'    => $record->fresh(),
        ]);
    }
    
}