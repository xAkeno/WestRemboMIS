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
Route::post('/login', [AuthController::class, 'login']);

// // Handle preflight requests
// Route::options('/*', function () {
//     return response()->json([], 200);
// });

// All routes - no authentication required
Route::middleware([EnsureTokenIsValid::class])->group(function () {
    Route::post('/register', [AuthController::class, 'register']);
    Route::get('/getAllUser', [AuthController::class, 'index']);
    Route::get('/users/{id}', [AuthController::class, 'show']);
    Route::put('/users/{id}/permissions', [AuthController::class, 'updatePermissions']);
    Route::get('/me', [AuthController::class, 'me']);

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

    Route::put('/barangay-certificates/status/{id}', [BarangaCertificateController::class, 'updateStatus']);
    Route::put('/building-clearances/status/{id}', [BarangayBuildingClearanceController::class, 'updateStatusBuilding']);
    Route::put('/business-clearances/status/{id}', [BarangayBusinessClearanceController::class, 'updateStatusBusiness']);
    Route::put('/residents/status/{id}', [ResidentController::class, 'updateStatusResident']);
    Route::put('/barangay-clearances/status/{id}', [BarangayClearanceController::class, 'updateStatusClearance']);

    
    Route::post('/logout', [AuthController::class, 'logout']);
});

