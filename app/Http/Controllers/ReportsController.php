<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\BarangayBusinessClearance;
use App\Models\BarangayBuildingClearance;
use App\Models\BarangayClearance;
use App\Models\BarangayCertificate;
use App\Models\Resident;
use Carbon\Carbon;

class ReportsController extends Controller
{
    // -----------------------------------------------------
    // 1. Apply Date Filter
    // -----------------------------------------------------
    private function applyDateFilters($query, Request $request)
    {
        if ($request->dateFrom && $request->dateTo) {
            return $query->whereBetween('created_at', [
                $request->dateFrom . ' 00:00:00',
                $request->dateTo . ' 23:59:59'
            ]);
        }

        switch ($request->filter_date) {
            case 'week':
                return $query->whereBetween('created_at', [
                    now()->startOfWeek(),
                    now()->endOfWeek()
                ]);
            case 'month':
                return $query->whereMonth('created_at', now()->month)
                             ->whereYear('created_at', now()->year);
            case 'year':
                return $query->whereYear('created_at', now()->year);
        }

        return $query;
    }

    // -----------------------------------------------------
    // 2. Apply Document Type Filter
    // -----------------------------------------------------
    private function applyDocumentTypeFilter($query, $type)
    {
        if (!$type || $type === 'all') return $query;

        return match ($type) {
            'business' => $query->where('id', '!=', null), // keep all business records
            'building' => $query->where('id', '!=', null), // same logic for building
            'brgy_clearance' => $query->where('id', '!=', null),
            'brgy_certificate' => $query->where('id', '!=', null),
            'resident' => $query->where('id', '!=', null),
            default => $query
        };
    }

    // -----------------------------------------------------
    // 3. OVERVIEW STATS
    // -----------------------------------------------------
    public function getOverview(Request $request)
    {
        return response()->json([
            'status' => 'success',
            'data' => [
                'business' => $this->applyDateFilters(BarangayBusinessClearance::query(), $request)->count(),
                'building' => $this->applyDateFilters(BarangayBuildingClearance::query(), $request)->count(),
                'barangay_clearance' => $this->applyDateFilters(BarangayClearance::query(), $request)->count(),
                'barangay_certificate' => $this->applyDateFilters(BarangayCertificate::query(), $request)->count(),
                'residents' => $this->applyDateFilters(Resident::query(), $request)->count(),
            ]
        ]);
    }

    // -----------------------------------------------------
    // 4. MONTHLY TRENDS (Line Chart)
    // -----------------------------------------------------
    public function getMonthlyTrends(Request $request)
    {
        $months = collect(range(1, 12))->map(fn($m) => Carbon::create(null, $m)->format('M'));
        $data = [];

        foreach ($months as $i => $monthName) {
            $month = $i + 1;

            $data[] = [
                'month' => $monthName,
                'business' => $this->applyDateFilters(BarangayBusinessClearance::whereMonth('created_at', $month), $request)->count(),
                'building' => $this->applyDateFilters(BarangayBuildingClearance::whereMonth('created_at', $month), $request)->count(),
                'barangay_clearance' => $this->applyDateFilters(BarangayClearance::whereMonth('created_at', $month), $request)->count(),
                'barangay_certificate' => $this->applyDateFilters(BarangayCertificate::whereMonth('created_at', $month), $request)->count(),
                'residents' => $this->applyDateFilters(Resident::whereMonth('created_at', $month), $request)->count(),
            ];
        }

        return response()->json(['status' => 'success', 'data' => $data]);
    }

    // -----------------------------------------------------
    // 5. DOCUMENT DISTRIBUTION (Pie)
    // -----------------------------------------------------
    public function getDistribution(Request $request)
    {
        return response()->json([
            'status' => 'success',
            'data' => [
                ['name' => 'Business Clearance', 'value' => $this->applyDateFilters(BarangayBusinessClearance::query(), $request)->count()],
                ['name' => 'Building Clearance', 'value' => $this->applyDateFilters(BarangayBuildingClearance::query(), $request)->count()],
                ['name' => 'Barangay Clearance', 'value' => $this->applyDateFilters(BarangayClearance::query(), $request)->count()],
                ['name' => 'Barangay Certificate', 'value' => $this->applyDateFilters(BarangayCertificate::query(), $request)->count()],
                ['name' => 'Residents', 'value' => $this->applyDateFilters(Resident::query(), $request)->count()],
            ]
        ]);
    }

    // -----------------------------------------------------
    // 6. STATUS OVERVIEW (Bar)
    // -----------------------------------------------------
    public function getStatusOverview(Request $request)
    {
        $released =
            $this->applyDateFilters(BarangayBusinessClearance::where('status', 'released'), $request)->count() +
            $this->applyDateFilters(BarangayBuildingClearance::where('status', 'released'), $request)->count() +
            $this->applyDateFilters(BarangayClearance::where('status', 'released'), $request)->count() +
            $this->applyDateFilters(BarangayCertificate::where('status', 'released'), $request)->count();

        $pending =
            $this->applyDateFilters(BarangayBusinessClearance::where('status', 'pending'), $request)->count() +
            $this->applyDateFilters(BarangayBuildingClearance::where('status', 'pending'), $request)->count() +
            $this->applyDateFilters(BarangayClearance::where('status', 'pending'), $request)->count() +
            $this->applyDateFilters(BarangayCertificate::where('status', 'pending'), $request)->count();

        $rejected =
            $this->applyDateFilters(BarangayBusinessClearance::where('status', 'rejected'), $request)->count() +
            $this->applyDateFilters(BarangayBuildingClearance::where('status', 'rejected'), $request)->count() +
            $this->applyDateFilters(BarangayClearance::where('status', 'rejected'), $request)->count() +
            $this->applyDateFilters(BarangayCertificate::where('status', 'rejected'), $request)->count();

        return response()->json([
            'status' => 'success',
            'data' => [
                ['name' => 'Released', 'value' => $released], // Changed here
                ['name' => 'Pending', 'value' => $pending],
                ['name' => 'Rejected', 'value' => $rejected],
            ]
        ]);
    }

    // -----------------------------------------------------
    // 7. MONTHLY COMPARISON (Bar Chart)
    // -----------------------------------------------------
    public function getMonthlyComparison(Request $request)
    {
        $months = collect(range(1, 12))->map(fn($m) => Carbon::create(null, $m)->format('M'));
        $data = [];

        foreach ($months as $i => $monthName) {
            $month = $i + 1;

            $data[] = [
                'month' => $monthName,
                'business' => $this->applyDateFilters(BarangayBusinessClearance::whereMonth('created_at', $month), $request)->count(),
                'building' => $this->applyDateFilters(BarangayBuildingClearance::whereMonth('created_at', $month), $request)->count(),
                'barangay_clearance' => $this->applyDateFilters(BarangayClearance::whereMonth('created_at', $month), $request)->count(),
                'barangay_certificate' => $this->applyDateFilters(BarangayCertificate::whereMonth('created_at', $month), $request)->count(),
            ];
        }

        return response()->json(['status' => 'success', 'data' => $data]);
    }
}
