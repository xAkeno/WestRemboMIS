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

        // ── Ticket Queue (Pending tickets sorted) ───────────────────
        $tickets = Ticket::with('serviceable')
            ->whereIn('status', ['Pending', 'Encoded'])
            ->orderByRaw("FIELD(status, 'Pending', 'Encoded')")
            ->orderByRaw("FIELD(priority, 'High', 'Normal', 'Low')")
            ->orderBy('submitted_at', 'asc')
            ->get();

        // ── Now Serving ─────────────────────────────────────────────
        $nowServing = Ticket::with('serviceable')
            ->where('status', 'Pending')
            ->orderByRaw("FIELD(priority, 'High', 'Normal', 'Low')")
            ->orderBy('submitted_at', 'asc')
            ->first();

        // ── Notifications ────────────────────────────────────────────
        $notifications = Notification::latest()->take(20)->get()->map(function ($n) {
            return [
                'id'      => $n->id,
                'message' => $n->message,
                'time'    => $n->created_at,
                'type'    => $n->type,
            ];
        });

        // ── Latest Activities (current user only from ActivityLogger) ─
        // ── Latest Activities (current user only from ActivityLogger) ─
        $user = Auth::user();

        // Temporary debug — remove after fixing
        \Log::info('Dashboard auth check', [
            'user'    => $user,
            'id'      => optional($user)->id,
            'guards'  => array_keys(config('auth.guards')),
        ]);

        $latestActivities = collect();

        if ($user) {
            $latestActivities = ActivityLogger::query()
                ->where('user_id', $user->id)
                ->orderBy('created_at', 'desc')
                ->take(10)
                ->get()
                ->map(function ($log) {
                    return [
                        'action'      => $log->action,
                        'description' => $log->description,
                        'type'        => $log->type,
                        'created_at'  => $log->created_at,
                    ];
                });
        } else {
            // Fallback: try getting user from request manually
            $user = $request->user();
            \Log::info('Fallback user from request', ['user' => $user]);

            if ($user) {
                $latestActivities = ActivityLogger::query()
                    ->where('user_id', $user->id)
                    ->orderBy('created_at', 'desc')
                    ->take(10)
                    ->get()
                    ->map(function ($log) {
                        return [
                            'action'      => $log->action,
                            'description' => $log->description,
                            'type'        => $log->type,
                            'created_at'  => $log->created_at,
                        ];
                    });
            }
        }
        // ── Total Released Today ──────────────────────────────────────
        $today = Carbon::today();
        $totalReleasedToday = BcertModel::where('status', 'RELEASED')
            ->count();

        return response()->json([
            'data' => [
                // Chart
                'barangay_clearances'   => $barangayClearance->getData(),
                'business_clearances'   => $businessClearance->getData(),
                'building_clearances'   => $buildingClearance->getData(),
                'barangay_certificates' => $barangayCertificate->getData(),
                'residents'             => $residents->getData(),

                // Sidebar + Dashboard extras
                'pending_counts'        => $pendingCounts,
                'tickets'               => $tickets,
                'now_serving'           => $nowServing,
                'notifications'         => $notifications,
                'latest_activities'     => $latestActivities,
                'total_released_today'  => $totalReleasedToday,
            ]
        ]);
    }
}