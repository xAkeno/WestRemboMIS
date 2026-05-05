<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\BarangayCertificate;
use App\Services\TicketService;
use App\Http\Requests\StoreBarangayCertificateRequest;
use App\Http\Requests\UpdateBarangayCertificateRequest;
use App\Traits\ExtractsUserFromAuthToken;
use Illuminate\Support\Facades\Log;
use App\Models\Ticket;
use Illuminate\Support\Str;
use Carbon\Carbon;
use App\Models\ActivityLogger;
use Illuminate\Support\Facades\DB;
class BarangaCertificateController extends Controller
{
    use ExtractsUserFromAuthToken;

    public function index(Request $request)
    {
        // Auto-expire documents
        BarangayCertificate::where('status', 'RELEASED')
            ->whereNotNull('expires_at')
            ->where('expires_at', '<=', Carbon::now())
            ->update(['status' => 'EXPIRED']);

        $query = BarangayCertificate::with([
            'schedule:id,document_number,schedule_date,schedule_time,user_id'
        ]);

        $columns = [
            'bcert_number',
            'prefix',
            'first_name',
            'middle_name',
            'surname',
            'extension',
            'house_block_lot_no',
            'street',
            'zone',
            'purpose',
            'purpose_details',
            'status',
        ];

        if ($request->filled('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($columns, $search) {
                foreach ($columns as $col) {
                    $q->orWhere($col, 'like', "%{$search}%");
                }
                // PostgreSQL-compatible full-name search (CONCAT_WS is supported in PG 9+)
                $q->orWhereRaw(
                    "CONCAT_WS(' ', first_name, middle_name, surname) ILIKE ?",
                    ["%{$search}%"]
                );
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
            if ($request->schedule_filter === 'scheduled') {
                $query->whereHas('schedule');
            } elseif ($request->schedule_filter === 'not_scheduled') {
                $query->whereDoesntHave('schedule');
            }
        }

        $sortField     = Str::snake($request->get('sortField', 'created_at'));
        $sortDirection = $request->get('sortDirection', 'desc');
        $allowedSorts  = ['created_at', 'surname', 'first_name', 'bcert_number', 'zone', 'status'];

        if (! in_array($sortField, $allowedSorts)) {
            $sortField = 'created_at';
        }

        $query->orderBy($sortField, $sortDirection);

        $perPage = $request->get('pageSize', 15);
        $data    = $query->paginate($perPage);

        return response()->json([
            'status'  => 'success',
            'message' => 'Results successfully retrieved',
            'data'    => $data,
        ], 200);
    }

    public function chartData(Request $request)
    {
        $filter = $request->filter_date ?? 'month';
        $from   = $request->from ?? null;
        $to     = $request->to   ?? null;
 
        $query = BarangayCertificate::query();
 
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
            'message' => 'Barangay certificates total retrieved successfully',
            'data'    => BarangayCertificate::count(),
        ]);
    }

    public function store(StoreBarangayCertificateRequest $request)
    {
        DB::beginTransaction();

        try {
            // ✅ Step 1: Lock a real row (certificate table)
            $exists = DB::table('barangay_certificates')->exists();

            if ($exists) {
                DB::table('barangay_certificates')
                    ->orderByDesc('id')
                    ->limit(1)
                    ->lockForUpdate()
                    ->get();
            }

            // ✅ Step 2: Get max number from CERTIFICATE table
            $lastNumber = DB::table('barangay_certificates')
                ->selectRaw("
                    COALESCE(
                        MAX(CAST(SUBSTRING(bcert_number FROM '[0-9]+$') AS INTEGER)),
                        0
                    ) as max_num
                ")
                ->value('max_num');

            $nextNumber = $lastNumber + 1;

            // ✅ Correct prefix
            $newRecord = 'BCERT-' . str_pad($nextNumber, 3, '0', STR_PAD_LEFT);

            // ✅ Correct data + model
            $data                 = $request->validated();
            $data['bcert_number'] = $newRecord;
            $data['status']       = 'ENCODED';
            $data['created_by']   = $this->getUserIdFromAuthToken();
            $data['updated_by']   = $this->getUserIdFromAuthToken();

            $certificate = BarangayCertificate::create($data);

            activity_log(
                'Barangay Certificate Created',
                'create',
                'Created BCERT #: ' . $certificate->bcert_number
            );

            // ✅ Correct service type
            $kiosk = \App\Models\Kiosk::where('service_type', 'Barangay Certificate')
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
                'message' => 'Barangay Certificate created successfully',
                'data'    => [
                    'service' => $certificate,
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
        $lastCertificate = BarangayCertificate::latest('created_at')->first();
        $lastNumber      = $lastCertificate ? intval(substr($lastCertificate->bcert_number, 6)) : 0;
        $newRecord       = 'BCERT-' . str_pad($lastNumber + 1, 3, '0', STR_PAD_LEFT);

        $lastId = BarangayCertificate::latest('id')->first();
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

    public function update(UpdateBarangayCertificateRequest $request, BarangayCertificate $barangayCertificate)
    {
        $data = $request->validated();
        $barangayCertificate->update($data);

        activity_log(
            'Barangay Certificate Updated',
            'update',
            'Updated BCERT #: ' . $barangayCertificate->bcert_number
        );

        // ✅ Notify user
        $user = \App\Models\User::whereRaw('LOWER(first_name) = ?', [strtolower($barangayCertificate->first_name)])
            ->whereRaw('LOWER(surname) = ?', [strtolower($barangayCertificate->surname)])
            ->first();

        if ($user) {
            \App\Models\Notification::create([
                'user_id'      => $user->id,
                'title'        => 'Barangay Certificate Updated',
                'message'      => 'Your Barangay Certificate has been updated. (Ref #: ' . $barangayCertificate->bcert_number . ')',
                'type'         => 'certificate',
                'reference_id' => $barangayCertificate->id,
            ]);
        }

        return response()->json([
            'status'  => 'success',
            'message' => 'Successfully updated the certificate',
            'data'    => $barangayCertificate->fresh(),
        ]);
    }

    public function updateStatus(Request $request, $id)
    {
        $validated = $request->validate([
            'status' => 'required|in:PENDING,ENCODED,INCOMPLETE,REJECTED,RELEASED,SCHEDULED,EXPIRED,PAID,TO_PAY,INSPECTING,ARCHIVED',
        ]);

        $record = BarangayCertificate::findOrFail($id);

        $newStatus = strtoupper($validated['status']);

         // ✅ Handle PAID
       if ($newStatus === 'PAID') {
            $record->issued_date = now();
            // $record->issued_at   = 'Barangay Hall';
            // $record->issued_on   = now();  // ✅ ADD THIS
        }

        if ($newStatus === 'RELEASED') {
            $record->issued_date = $record->issued_date ?? now();
            // $record->issued_at   = $record->issued_at ?? 'Barangay Hall';
            // $record->issued_on   = $record->issued_on ?? now();  // ✅ ADD THIS
            $record->expires_at  = now()->addMonths(6); // 12 months
        }

        // Status labels
        $statusLabels = [
            'PENDING'    => ['label' => 'Pending',    'message' => 'Your Barangay Certificate is now pending review.'],
            'ENCODED'    => ['label' => 'Encoded',    'message' => 'Your Barangay Certificate has been encoded.'],
            'INCOMPLETE' => ['label' => 'Incomplete', 'message' => 'Your Barangay Certificate is incomplete.'],
            'REJECTED'   => ['label' => 'Rejected',   'message' => 'Your Barangay Certificate has been rejected.'],
            'RELEASED'   => ['label' => 'Released',   'message' => 'Your Barangay Certificate is ready for release.'],
            'SCHEDULED'  => ['label' => 'Scheduled',  'message' => 'Your Barangay Certificate has been scheduled.'],
            'EXPIRED'    => ['label' => 'Expired',    'message' => 'Your Barangay Certificate has expired.'],
            'PAID'       => ['label' => 'Paid',       'message' => 'Payment confirmed for your Barangay Certificate.'],
            'TO_PAY'     => ['label' => 'For Payment','message' => 'Your Barangay Certificate is ready for payment.'],
            'INSPECTING' => ['label' => 'Inspecting', 'message' => 'Your Barangay Certificate is currently being inspected.'],
            'ARCHIVED'   => ['label' => 'Archived',   'message' => 'Your Barangay Certificate has been archived.'],
        ];

        $statusInfo = $statusLabels[$newStatus] ?? null;

        if ($statusInfo) {

            $user = \App\Models\User::whereRaw('LOWER(first_name) = ?', [strtolower($record->first_name ?? '')])
                ->whereRaw('LOWER(surname) = ?', [strtolower($record->surname ?? '')])
                ->first();

            if ($user) {
                \App\Models\Notification::create([
                    'user_id'      => $user->id,
                    'title'        => 'Barangay Certificate — ' . $statusInfo['label'],
                    'message'      => $statusInfo['message'] . ' (Ref #: ' . $record->bcert_number . ')',
                    'type'         => 'certificate',
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
            'ARCHIVED' => 'archived',
        ];

        $ticketStatus = $ticketStatusMap[$newStatus] ?? null;

        if ($ticketStatus) {
            $kiosk = \App\Models\Kiosk::where('service_type', 'Barangay Certificate')
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
            'Barangay Certificate Status Updated',
            'status_update',
            'Changed to ' . $newStatus . ' (BCERT #: ' . $record->bcert_number . ')'
        );

        return response()->json([
            'status'  => 'success',
            'message' => 'Status updated successfully',
            'data'    => $record,
        ], 200);
    }

    public function destroy(BarangayCertificate $barangayCertificate)
    {
        $bcertNumber = $barangayCertificate->bcert_number;
        $barangayCertificate->delete();

        activity_log('Barangay Certificate Deleted', 'delete_delete', 'Deleted BCERT #: ' . $bcertNumber);

        return response()->json([
            'status'  => 'success',
            'message' => 'Barangay certificate deleted successfully',
            'data'    => null,
        ]);
    }

    public function setDisposition(Request $request, $id)
    {
        $validated = $request->validate([
            'status' => 'required|in:REJECTED,INCOMPLETE',
            'reason' => 'required|string|max:1000',
        ]);

        $record = BarangayCertificate::findOrFail($id);

        $newStatus = strtoupper($validated['status']);

        // update record
        $record->status = $newStatus;
        $record->rejection_reason = $validated['reason'];
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
            'ARCHIVED' => [
                'label' => 'Archived',
                'message' => 'Your Barangay Certificate has been archived.'
            ],
        ];

        $statusInfo = $statusLabels[$newStatus] ?? null;

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