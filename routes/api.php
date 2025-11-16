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
    Route::post('/logout', [AuthController::class, 'logout']);
});

