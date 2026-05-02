<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreBarangayBusinessClearanceRequest;
use App\Http\Requests\UpdateBarangayBusinessClearanceRequest;
use App\Models\BarangayBusinessClearance;
use App\Services\TicketService;
use App\Traits\ExtractsUserFromAuthToken;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;
use App\Models\Ticket;
use Carbon\Carbon;
use App\Models\ActivityLogger;
use Illuminate\Support\Facades\DB;
class BarangayBusinessClearanceController extends Controller
{
    use ExtractsUserFromAuthToken;

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        // Auto-expire documents
        BarangayBusinessClearance::where('status', 'RELEASED')
            ->whereNotNull('expires_at')
            ->where('expires_at', '<=', Carbon::now())
            ->update(['status' => 'EXPIRED']);

        $query = BarangayBusinessClearance::with([
            'schedule:id,document_number,schedule_date,schedule_time,user_id'
        ]);

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
        $allowedSorts  = ['created_at', 'surname', 'first_name', 'business_name', 'status'];

        if (! in_array($sortField, $allowedSorts)) {
            $sortField = 'created_at';
        }

        $query->orderBy($sortField, $sortDirection);

        $perPage    = $request->get('pageSize', 15);
        $clearances = $query->paginate($perPage);

        return response()->json([
            'status'  => 'success',
            'message' => 'Business clearances retrieved successfully',
            'data'    => $clearances,
        ]);
    }

    public function chartData(Request $request)
    {
        $filter = $request->filter_date ?? 'month';
        $from   = $request->from ?? null;
        $to     = $request->to   ?? null;
 
        $query = BarangayBusinessClearance::query();
 
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
            'message' => 'Business clearance total retrieved successfully',
            'data'    => BarangayBusinessClearance::count(),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreBarangayBusinessClearanceRequest $request)
    {
        DB::beginTransaction();

        try {
            // ✅ Step 1: Lock rows FIRST (no aggregate)
            DB::table('barangay_business_clearances')
                ->select('id')
                ->orderByDesc('id')
                ->limit(1)
                ->lockForUpdate()
                ->get();

            // ✅ Step 2: Get MAX number safely
            $lastNumber = DB::table('barangay_business_clearances')
                ->selectRaw("
                    COALESCE(
                        MAX(CAST(SUBSTRING(brgy_business_no FROM '[0-9]+$') AS INTEGER)),
                        0
                    ) as max_num
                ")
                ->value('max_num');

            $nextNumber = $lastNumber + 1;

            $newRecord = 'BBUSINESS-' . str_pad($nextNumber, 3, '0', STR_PAD_LEFT);

            // ✅ Your original logic
            $data                     = $request->validated();
            $data['brgy_business_no'] = $newRecord;
            $data['status']           = 'ENCODED';
            $data['created_by']       = $this->getUserIdFromAuthToken();
            $data['updated_by']       = $this->getUserIdFromAuthToken();

            $clearance = BarangayBusinessClearance::create($data);

            activity_log(
                'Business Clearance Created',
                'create',
                'Created #: ' . $clearance->brgy_business_no
            );

            // ✅ Kiosk logic (unchanged)
            $kiosk = \App\Models\Kiosk::where('service_type', 'Business Clearance')
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
                'message' => 'Business clearance created successfully',
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
        $lastClearance = BarangayBusinessClearance::latest('created_at')->first();
        $lastNumber    = $lastClearance ? intval(substr($lastClearance->brgy_business_no, 11)) : 0;
        $newRecord     = 'BBUSINESS-' . str_pad($lastNumber + 1, 3, '0', STR_PAD_LEFT);

        $lastId = BarangayBusinessClearance::latest('id')->first();
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
    public function show(BarangayBusinessClearance $barangayBusinessClearance)
    {
        return response()->json([
            'status'  => 'success',
            'message' => 'Business clearance retrieved successfully',
            'data'    => $barangayBusinessClearance,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateBarangayBusinessClearanceRequest $request, $id)
    {
        $record = BarangayBusinessClearance::findOrFail($id);

        $oldStatus = strtoupper($record->status);

        $data = $request->validated();
        $record->update($data);

        $newStatus = strtoupper($record->status);

        // Only proceed if status actually changed
        if ($oldStatus !== $newStatus) {

            $statusLabels = [
                'PENDING'    => ['label' => 'Pending',    'message' => 'Your Business Clearance application is now pending review.'],
                'ENCODED'    => ['label' => 'Encoded',    'message' => 'Your Business Clearance has been encoded.'],
                'INCOMPLETE' => ['label' => 'Incomplete', 'message' => 'Your Business Clearance is incomplete.'],
                'REJECTED'   => ['label' => 'Rejected',   'message' => 'Your Business Clearance was rejected.'],
                'RELEASED'   => ['label' => 'Released',   'message' => 'Your Business Clearance is ready for release.'],
                'SCHEDULED'  => ['label' => 'Scheduled',  'message' => 'Your Business Clearance has been scheduled.'],
                'EXPIRED'    => ['label' => 'Expired',    'message' => 'Your Business Clearance has expired.'],
                'PAID'       => ['label' => 'Paid',       'message' => 'Payment confirmed for your Business Clearance.'],
                'TO_PAY'     => ['label' => 'For Payment','message' => 'Your Business Clearance is ready for payment.'],
                'INSPECTING' => ['label' => 'Inspecting', 'message' => 'Your Business Clearance is currently being inspected.'],
            ];

            $statusInfo = $statusLabels[$newStatus] ?? null;

            if ($statusInfo) {

                $user = \App\Models\User::whereRaw(
                    'LOWER(first_name) = ?',
                    [strtolower($record->first_name)]
                )->whereRaw(
                    'LOWER(surname) = ?',
                    [strtolower($record->surname)]
                )->first();

                if ($user) {
                    \App\Models\Notification::create([
                        'user_id'      => $user->id,
                        'title'        => 'Business Clearance — ' . $statusInfo['label'],
                        'message'      => $statusInfo['message'] . ' (Ref #: ' . $record->brgy_business_no . ')',
                        'type'         => 'business_clearance',
                        'reference_id' => $record->id,
                    ]);
                }
            }
        }

        activity_log(
            'Business Clearance Updated',
            'update',
            'Updated #: ' . $record->brgy_business_no
        );

        return response()->json([
            'status'  => 'success',
            'message' => 'Business clearance updated successfully',
            'data'    => $record->fresh(),
        ]);
    }

    public function updateStatusBusiness(Request $request, $id)
    {
        $validated = $request->validate([
            'status' => 'required|in:PENDING,ENCODED,INCOMPLETE,REJECTED,RELEASED,SCHEDULED,EXPIRED,PAID,TO_PAY,INSPECTING',
        ]);

        $record = BarangayBusinessClearance::findOrFail($id);

        $oldStatus = strtoupper($record->status);
        $newStatus = strtoupper($validated['status']);

        // Update status FIRST
        $record->status = $newStatus;

        if ($newStatus === 'PAID') {
            $record->issued_date = now();
            // $record->issued_at   = 'Barangay Hall';
            // $record->issued_on   = now();  // ✅ ADD THIS
        }

        if ($newStatus === 'RELEASED') {
            $record->issued_date = $record->issued_date ?? now();
            // $record->issued_at   = $record->issued_at ?? 'Barangay Hall';
            // $record->issued_on   = $record->issued_on ?? now();  // ✅ ADD THIS
            $record->expires_at  = now()->addYear(); // 12 months
        }

        $record->save();

        // Only trigger notification if status changed
        if ($oldStatus !== $newStatus) {

            $statusLabels = [
                'PENDING'    => ['label' => 'Pending',    'message' => 'Your Business Clearance application is now pending review.'],
                'ENCODED'    => ['label' => 'Encoded',    'message' => 'Your Business Clearance has been encoded.'],
                'INCOMPLETE' => ['label' => 'Incomplete', 'message' => 'Your Business Clearance is incomplete.'],
                'REJECTED'   => ['label' => 'Rejected',   'message' => 'Your Business Clearance was rejected.'],
                'RELEASED'   => ['label' => 'Released',   'message' => 'Your Business Clearance is ready for release.'],
                'SCHEDULED'  => ['label' => 'Scheduled',  'message' => 'Your Business Clearance has been scheduled.'],
                'EXPIRED'    => ['label' => 'Expired',    'message' => 'Your Business Clearance has expired.'],
                'PAID'       => ['label' => 'Paid',       'message' => 'Payment confirmed for your Business Clearance.'],
                'TO_PAY'     => ['label' => 'For Payment','message' => 'Your Business Clearance is ready for payment.'],
                'INSPECTING' => ['label' => 'Inspecting', 'message' => 'Your Business Clearance is currently being inspected.'],
            ];

            $statusInfo = $statusLabels[$newStatus] ?? null;

            if ($statusInfo) {

                $user = \App\Models\User::whereRaw(
                    'LOWER(first_name) = ?',
                    [strtolower($record->first_name)]
                )->whereRaw(
                    'LOWER(surname) = ?',
                    [strtolower($record->surname)]
                )->first();

                if ($user) {
                    \App\Models\Notification::create([
                        'user_id'      => $user->id,
                        'title'        => 'Business Clearance — ' . $statusInfo['label'],
                        'message'      => $statusInfo['message'] . ' (Ref #: ' . $record->brgy_business_no . ')',
                        'type'         => 'business_clearance',
                        'reference_id' => $record->id,
                    ]);
                }
            }
        }

        // Ticket mapping
        $ticketStatusMap = [
            'PENDING'  => 'pending',
            'ENCODED'  => 'called',
            'RELEASED' => 'released',
        ];

        $ticketStatus = $ticketStatusMap[$newStatus] ?? null;

        if ($ticketStatus) {

            $kiosk = \App\Models\Kiosk::where('service_type', 'Business Clearance')
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
            'Business Clearance Status Updated',
            'status_update',
            'Changed to ' . $newStatus . ' (#: ' . $record->brgy_business_no . ')'
        );

        return response()->json([
            'status'  => 'success',
            'message' => 'Business clearance status updated successfully',
            'data'    => $record,
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(BarangayBusinessClearance $barangayBusinessClearance)
    {
        if ($barangayBusinessClearance->attachment) {
            Storage::disk('public')->delete($barangayBusinessClearance->attachment);
        }

        $brgyBusinessNo = $barangayBusinessClearance->brgy_business_no;

        $barangayBusinessClearance->delete();

        activity_log(
            'Business Clearance Deleted',
            'delete_document',
            'Deleted #: ' . $brgyBusinessNo
        );

        return response()->json([
            'status'  => 'success',
            'message' => 'Business clearance deleted successfully',
            'data'    => null,
        ]);
    }
    public function setDisposition(Request $request, $id)
    {
        $validated = $request->validate([
            'status' => 'required|in:REJECTED,INCOMPLETE',
            'reason' => 'required|string|max:1000',
        ]);

        $record = BarangayBusinessClearance::findOrFail($id);

        $oldStatus = strtoupper($record->status);
        $newStatus = strtoupper($validated['status']);

        // Update status + reason
        $record->status = $newStatus;
        $record->rejection_reason = $validated['reason']; // <-- uses your migration column
        $record->save();

        $statusLabels = [
            'REJECTED' => [
                'label' => 'Rejected',
                'message' => 'Your Barangay Certificate application was rejected.'
            ],
            'INCOMPLETE' => [
                'label' => 'Incomplete',
                'message' => 'Your Barangay Certificate application is incomplete.'
            ],
        ];

        $statusInfo = $statusLabels[$newStatus] ?? null;

        // Notify user
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
                    'title'        => 'Barangay Certificate — ' . $statusInfo['label'],
                    'message'      =>
                        $statusInfo['message'] .
                        ' Reason: ' . $validated['reason'] .
                        ' (Ref #: ' . $record->bcert_number . ')',
                    'type'         => 'certificate',
                    'reference_id' => $record->id,
                ]);
            }
        }


        return response()->json([
            'status'  => 'success',
            'message' => "Barangay Certificate marked as {$newStatus}",
            'data'    => $record->fresh(),
        ]);
    }               
    
}