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

        // ── Comprehensive Record Counts per Service Type ──────────────
        $incompleteStatuses = ['Pending', 'pending', 'for review', 'new', 'encoded', 'Encoded'];

        $recordsCounts = [
            'Barangay Clearance' => [
                'total'      => BarangayClearance::count(),
                'released'   => BarangayClearance::where('status', 'RELEASED')->count(),
                'incomplete' => BarangayClearance::whereIn('status', $incompleteStatuses)->count(),
                'rejected'   => BarangayClearance::where('status', 'REJECTED')->count(),
            ],
            'Business Clearance' => [
                'total'      => BarangayBusinessClearance::count(),
                'released'   => BarangayBusinessClearance::where('status', 'RELEASED')->count(),
                'incomplete' => BarangayBusinessClearance::whereIn('status', $incompleteStatuses)->count(),
                'rejected'   => BarangayBusinessClearance::where('status', 'REJECTED')->count(),
            ],
            'Building Clearance' => [
                'total'      => BarangayBuildingClearance::count(),
                'released'   => BarangayBuildingClearance::where('status', 'RELEASED')->count(),
                'incomplete' => BarangayBuildingClearance::whereIn('status', $incompleteStatuses)->count(),
                'rejected'   => BarangayBuildingClearance::where('status', 'REJECTED')->count(),
            ],
            'Barangay Certificate' => [
                'total'      => BarangayCertificate::count(),
                'released'   => BarangayCertificate::where('status', 'RELEASED')->count(),
                'incomplete' => BarangayCertificate::whereIn('status', $incompleteStatuses)->count(),
                'rejected'   => BarangayCertificate::where('status', 'REJECTED')->count(),
            ],
        ];

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
        ///////////////////////////////////
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
        $today = Carbon::now(config('app.timezone'))->toDateString();

        // ── Load today's schedules keyed by document_number ───────────
        $todaySchedules = DB::table('schedules')
            ->whereDate('schedule_date', $today)
            ->get()
            ->keyBy('document_number');

        // ── Helper: build today's list for one model ──────────────────
        $todayList = function (string $modelClass, string $docNumberColumn, string $documentType) use ($todaySchedules) {
            return $modelClass::query()
                ->where('status', 'SCHEDULED')
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
                // ── Charts ──────────────────────────────────────────
                'barangay_clearances'   => $barangayClearance->getData(),
                'business_clearances'   => $businessClearance->getData(),
                'building_clearances'   => $buildingClearance->getData(),
                'barangay_certificates' => $barangayCertificate->getData(),

                // ── Meta ────────────────────────────────────────────
                'records_counts'       => $recordsCounts,
                'notifications'        => $notifications,
                'latest_activities'    => $latestActivities,

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
            ]
        ]);
    }
}