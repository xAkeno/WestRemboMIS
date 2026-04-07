<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Traits\ExtractsUserFromAuthToken;

use App\Models\BarangayBusinessClearance;
use App\Models\BarangayCertificate;
use App\Models\BarangayClearance;
use App\Models\BarangayBuildingClearance;
use App\Models\Resident;
class MyAllRequestsController extends Controller
{
    use ExtractsUserFromAuthToken;

    public function index()
    {
        try {
            $userId = $this->getUserIdFromAuthToken();

            if (!$userId) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Unauthorized'
                ], 401);
            }

            // Fetch from all tables
            $business = BarangayBusinessClearance::where('created_by', $userId)->get();
            $certificate = BarangayCertificate::where('created_by', $userId)->get();
            $clearance = BarangayClearance::where('created_by', $userId)->get();
            $building = BarangayBuildingClearance::where('created_by', $userId)->get();
            $resident = Resident::where('created_by', $userId)->get();
            return response()->json([
                'status' => 'success',
                'data' => [
                    'business' => $business,
                    'certificate' => $certificate,
                    'clearance' => $clearance,
                    'building' => $building,
                    'resident' => $resident
                ]
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ], 500);
        }
    }
}