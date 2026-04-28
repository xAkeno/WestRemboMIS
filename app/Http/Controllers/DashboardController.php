<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use App\Http\Controllers\BarangayClearanceController;
use App\Http\Controllers\BarangayBusinessClearanceController;
use App\Http\Controllers\BarangayBuildingClearanceController;
use App\Http\Controllers\BarangaCertificateController;
use App\Http\Controllers\ResidentController;
use Illuminate\Http\Request;
use App\Models\Ticket;
use App\Models\BarangayClearance;
use App\Models\BarangayBusinessClearance;
use App\Models\BarangayBuildingClearance;
use App\Models\BarangayCertificate;
use App\Models\Resident;
use App\Models\Notification;
use App\Models\BarangayCertificate as BcertModel;
use App\Models\ActivityLogger;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    public function index(Request $request)
    {
        // ── Chart Data ──────────────────────────────────────────────
        $barangayClearance   = app(BarangayClearanceController::class)->chartData($request);
        $businessClearance   = app(BarangayBusinessClearanceController::class)->chartData($request);
        $buildingClearance   = app(BarangayBuildingClearanceController::class)->chartData($request);
        $barangayCertificate = app(BarangaCertificateController::class)->chartData($request);
        $residents           = app(ResidentController::class)->chartData($request);

        // ── Pending Counts per Service Type ─────────────────────────
        $pendingStatuses = ['Pending', 'pending', 'for review', 'new', 'encoded', 'Encoded'];

        $pendingCounts = [
            'Barangay Clearance'   => BarangayClearance::whereIn('status', $pendingStatuses)->count(),
            'Business Clearance'   => BarangayBusinessClearance::whereIn('status', $pendingStatuses)->count(),
            'Building Clearance'   => BarangayBuildingClearance::whereIn('status', $pendingStatuses)->count(),
            'Barangay Certificate' => BarangayCertificate::whereIn('status', $pendingStatuses)->count(),
            'Resident'             => Resident::whereIn('status', $pendingStatuses)->count(),
        ];

        // ── Ticket Queue ─────────────────────────────────────────────
        $tickets = Ticket::with('serviceable')
            ->whereIn('status', ['Pending', 'Encoded', 'called', 'waiting', 'processing', 'late'])
            ->orderByRaw("FIELD(status, 'Pending', 'Encoded')")
            ->orderByRaw("FIELD(priority, 'High', 'Normal', 'Low')")
            ->orderBy('submitted_at', 'asc')
            ->get();

        // ── Now Serving ──────────────────────────────────────────────
        $nowServing = Ticket::with('serviceable')
            ->where('status', 'Pending')
            ->orderByRaw("FIELD(priority, 'High', 'Normal', 'Low')")
            ->orderBy('submitted_at', 'asc')
            ->first();

        // ── Notifications ─────────────────────────────────────────────
        $notifications = Notification::latest()->take(20)->get()->map(function ($n) {
            return [
                'id'      => $n->id,
                'message' => $n->message,
                'time'    => $n->created_at,
                'type'    => $n->type,
            ];
        });

        // ── Latest Activities ─────────────────────────────────────────
        $user = Auth::user() ?? $request->user();
        $latestActivities = collect();

        if ($user) {
            $latestActivities = ActivityLogger::query()
                ->where('user_id', $user->id)
                ->orderBy('created_at', 'desc')
                ->take(10)
                ->get()
                ->map(fn ($log) => [
                    'action'      => $log->action,
                    'description' => $log->description,
                    'type'        => $log->type,
                    'created_at'  => $log->created_at,
                ]);
        }

        // ── Total Released Today ──────────────────────────────────────
        $totalReleasedToday = BcertModel::where('status', 'RELEASED')->count();

        // ── Today's date (respects app timezone) ──────────────────────
        // Carbon::today() uses UTC by default which was returning the wrong
        // date. Carbon::now(config('app.timezone')) uses the timezone set
        // in config/app.php — make sure it is set to 'Asia/Manila'.
        $today = Carbon::now(config('app.timezone'))->toDateString();

        // ── Load today's schedules keyed by document_number ───────────
        $todaySchedules = DB::table('schedules')
            ->whereDate('schedule_date', $today)
            ->get()
            ->keyBy('document_number');

        // ── Helper: build today's list for one model ──────────────────
        $todayList = function (string $modelClass, string $docNumberColumn, string $documentType) use ($todaySchedules) {
            return $modelClass::query()
                ->where('status', 'SCHEDULED')  // ← ADD THIS LINE
                ->get()
                ->filter(function ($item) use ($todaySchedules, $docNumberColumn, $documentType) {
                    $docNumber = $item->{$docNumberColumn};
                    return isset($todaySchedules[$docNumber])
                        && $todaySchedules[$docNumber]->document_type === $documentType;
                })
                ->map(function ($item) use ($todaySchedules, $docNumberColumn) {
                    $schedule = $todaySchedules[$item->{$docNumberColumn}] ?? null;
                    return array_merge($item->toApi(), [
                        'schedule_date' => $schedule->schedule_date ?? null,
                        'schedule_time' => $schedule->schedule_time ?? null,
                    ]);
                })
                ->values();
        };

        return response()->json([
            'data' => [
                // ── Chart ───────────────────────────────────────────
                'barangay_clearances'   => $barangayClearance->getData(),
                'business_clearances'   => $businessClearance->getData(),
                'building_clearances'   => $buildingClearance->getData(),
                'barangay_certificates' => $barangayCertificate->getData(),
                'residents'             => $residents->getData(),

                // ── Meta ────────────────────────────────────────────
                'pending_counts'       => $pendingCounts,
                'tickets'              => $tickets,
                'now_serving'          => $nowServing,
                'notifications'        => $notifications,
                'latest_activities'    => $latestActivities,
                'total_released_today' => $totalReleasedToday,

                // ── Lists: only records scheduled for today ───────────
                'barangay_certificates_list' => $todayList(
                    \App\Models\BarangayCertificate::class,
                    'bcert_number',
                    'barangay_certificate'
                ),
                'barangay_clearances_list' => $todayList(
                    \App\Models\BarangayClearance::class,
                    'bcert_number',
                    'barangay_clearance'
                ),
                'building_clearances_list' => $todayList(
                    \App\Models\BarangayBuildingClearance::class,
                    'bcert_number',
                    'building_clearance'
                ),
                'business_clearances_list' => $todayList(
                    \App\Models\BarangayBusinessClearance::class,
                    'brgy_business_no',
                    'business_clearance'
                ),
                'residents_list' => [],
            ]
        ]);
    }
}