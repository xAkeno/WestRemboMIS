<?php

namespace App\Http\Controllers;

use App\Http\Controllers\BarangayClearanceController;
use App\Http\Controllers\BarangayBusinessClearanceController;
use App\Http\Controllers\BarangayBuildingClearanceController;
use App\Http\Controllers\BarangaCertificateController;
use Illuminate\Http\Request;
use App\Models\BarangayClearance;
use App\Models\BarangayBusinessClearance;
use App\Models\BarangayBuildingClearance;
use App\Models\BarangayCertificate;
use App\Models\Notification;
use App\Models\ActivityLogger;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    public function index(Request $request)
    {
        // ── Date Range (from / to) — applied globally ─────────────────
        $tz   = config('app.timezone');
        $from = $request->filled('from')
            ? Carbon::parse($request->input('from'), $tz)->startOfDay()
            : null;
        $to   = $request->filled('to')
            ? Carbon::parse($request->input('to'), $tz)->endOfDay()
            : null;

        // ── Helper: apply date range to any Eloquent builder ──────────
        $applyRange = function ($query) use ($from, $to) {
            if ($from) $query->where('created_at', '>=', $from);
            if ($to)   $query->where('created_at', '<=', $to);
            return $query;
        };

        // ── Chart Data (pass request so child controllers also use from/to) ──
        $barangayClearance   = app(BarangayClearanceController::class)->chartData($request);
        $businessClearance   = app(BarangayBusinessClearanceController::class)->chartData($request);
        $buildingClearance   = app(BarangayBuildingClearanceController::class)->chartData($request);
        $barangayCertificate = app(BarangaCertificateController::class)->chartData($request);

        // ── Statuses ──────────────────────────────────────────────────
        $incompleteStatuses = ['Pending', 'pending', 'for review', 'new', 'encoded', 'Encoded'];

        // ── Service definitions (DRY) ─────────────────────────────────
        $services = [
            'Barangay Clearance'   => BarangayClearance::class,
            'Business Clearance'   => BarangayBusinessClearance::class,
            'Building Clearance'   => BarangayBuildingClearance::class,
            'Barangay Certificate' => BarangayCertificate::class,
        ];

        // ── Comprehensive Record Counts per Service Type ──────────────
        $recordsCounts = [];
        foreach ($services as $label => $modelClass) {
            $recordsCounts[$label] = [
                'total'      => $applyRange($modelClass::query())->count(),
                'released'   => $applyRange($modelClass::query())->where('status', 'RELEASED')->count(),
                'incomplete' => $applyRange($modelClass::query())->whereIn('status', $incompleteStatuses)->count(),
                'rejected'   => $applyRange($modelClass::query())->where('status', 'REJECTED')->count(),
            ];
        }

        // ── Document Distribution by Type ─────────────────────────────
        // Total documents per service + percentage share of the grand total
        $distributionRaw = [];
        foreach ($services as $label => $modelClass) {
            $distributionRaw[$label] = $applyRange($modelClass::query())->count();
        }
        $grandTotal = array_sum($distributionRaw);

        $documentDistribution = [];
        foreach ($distributionRaw as $label => $count) {
            $documentDistribution[] = [
                'type'       => $label,
                'count'      => $count,
                'percentage' => $grandTotal > 0
                    ? round(($count / $grandTotal) * 100, 2)
                    : 0,
            ];
        }

        // ── Monthly Comparison ────────────────────────────────────────
        // Current month vs previous month counts for each service type.
        // If a from/to filter is active the "current period" uses those
        // bounds, and "previous period" shifts them back by the same span.
        if ($from && $to) {
            $spanDays    = (int) $from->diffInDays($to) + 1;
            $prevFrom    = $from->copy()->subDays($spanDays);
            $prevTo      = $to->copy()->subDays($spanDays);
            $periodLabel = $from->toDateString() . ' – ' . $to->toDateString();
            $prevLabel   = $prevFrom->toDateString() . ' – ' . $prevTo->toDateString();
        } else {
            $now         = Carbon::now($tz);
            $prevFrom    = $now->copy()->startOfMonth()->subMonth();
            $prevTo      = $prevFrom->copy()->endOfMonth();
            $from        = $now->copy()->startOfMonth();   // local alias for current-month queries
            $to          = $now->copy()->endOfDay();
            $periodLabel = $now->format('F Y');
            $prevLabel   = $prevFrom->format('F Y');
        }

        $monthlyComparison = [];
        foreach ($services as $label => $modelClass) {
            $current  = $modelClass::query()
                ->whereBetween('created_at', [$from,     $to])
                ->count();
            $previous = $modelClass::query()
                ->whereBetween('created_at', [$prevFrom, $prevTo])
                ->count();

            $change = $previous > 0
                ? round((($current - $previous) / $previous) * 100, 2)
                : ($current > 0 ? 100.0 : 0.0);

            $monthlyComparison[] = [
                'type'            => $label,
                'current_count'   => $current,
                'previous_count'  => $previous,
                'change_percent'  => $change,      // positive = growth, negative = decline
                'current_period'  => $periodLabel,
                'previous_period' => $prevLabel,
            ];
        }

        // ── Notifications ─────────────────────────────────────────────
        $notifications = Notification::latest()->take(20)->get()->map(fn ($n) => [
            'id'      => $n->id,
            'message' => $n->message,
            'time'    => $n->created_at,
            'type'    => $n->type,
        ]);

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

        // ── Today's date (respects app timezone) ──────────────────────
        $today = Carbon::now($tz)->toDateString();

        // ── Load today's schedules keyed by document_number ───────────
        $todaySchedules = DB::table('schedules')
            ->whereDate('schedule_date', $today)
            ->get()
            ->keyBy('document_number');

        // ── Helper: build today's scheduled list for one model ────────
        $todayList = function (
            string $modelClass,
            string $docNumberColumn,
            string $documentType
        ) use ($todaySchedules, $applyRange) {
            return $applyRange($modelClass::query()->where('status', 'SCHEDULED'))
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

        // ── Response ──────────────────────────────────────────────────
        return response()->json([
            'data' => [
                // Charts
                'barangay_clearances'   => $barangayClearance->getData(),
                'business_clearances'   => $businessClearance->getData(),
                'building_clearances'   => $buildingClearance->getData(),
                'barangay_certificates' => $barangayCertificate->getData(),

                // Meta
                'records_counts'         => $recordsCounts,
                'notifications'          => $notifications,
                'latest_activities'      => $latestActivities,

                // New: distribution + monthly comparison
                'document_distribution'  => $documentDistribution,
                'monthly_comparison'     => $monthlyComparison,

                // Today's scheduled lists
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
            ]
        ]);
    }
}