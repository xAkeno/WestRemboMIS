<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\BarangayBuildingClearanceController;
use App\Http\Controllers\BarangayBusinessClearanceController;
use App\Http\Controllers\BarangaCertificateController;
use App\Http\Controllers\BarangayClearanceController;
use App\Http\Controllers\ResidentController;
use Illuminate\Support\Facades\Route;
use App\Http\Middleware\EnsureTokenIsValid;

// Public routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

// // Handle preflight requests
// Route::options('/*', function () {
//     return response()->json([], 200);
// });

// All routes - no authentication required
Route::middleware([EnsureTokenIsValid::class])->group(function () {
    Route::apiResource('residents', ResidentController::class);
    Route::apiResource('business-clearances', BarangayBusinessClearanceController::class);
    Route::apiResource('building-clearances', BarangayBuildingClearanceController::class);
    Route::apiResource('barangay-clearances', BarangayClearanceController::class);
    Route::apiResource('barangay-certificates', BarangaCertificateController::class);

    // Route::get('/latestRecordBrgyResident', [ResidentController::class, 'latestRecord']);
    Route::get('/latestRecordBrgyClearance', [BarangayClearanceController::class, 'latestRecord']);
    Route::get('/latestRecordBrgyBusiness', [BarangayBusinessClearanceController::class, 'latestRecord']);
    Route::get('/latestRecordBrgyBuilding', [BarangayBuildingClearanceController::class, 'latestRecord']);
    Route::get('/latestRecordBrgyCertificates', [BarangaCertificateController::class, 'latestRecord']);

    Route::get('/chart/barangay-clearances', [BarangayClearanceController::class, 'chartData']);
    Route::get('/chart/business-clearances', [BarangayBusinessClearanceController::class, 'chartData']);
    Route::get('/chart/building-clearances', [BarangayBuildingClearanceController::class, 'chartData']);
    Route::get('/chart/barangay-certificates', [BarangaCertificateController::class, 'chartData']);
    Route::get('/chart/residents', [ResidentController::class, 'chartData']);
    
    Route::post('/logout', [AuthController::class, 'logout']);
});

