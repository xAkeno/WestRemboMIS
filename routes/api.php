<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\BarangayBuildingClearanceController;
use App\Http\Controllers\BarangayBusinessClearanceController;
use App\Http\Controllers\BarangaCertificateController;
use App\Http\Controllers\BarangayClearanceController;
use App\Http\Controllers\ResidentController;
use Illuminate\Support\Facades\Route;
use App\Http\Middleware\EnsureTokenIsValid;
use App\Http\Controllers\ReportsController;
use App\Http\Controllers\LatestDashboard;
use App\Http\Controllers\KioskController;
use App\Http\Controllers\BackupController;
use Illuminate\Support\Facades\Artisan;
use App\Http\Controllers\DocumentController;
use App\Http\Controllers\StreetController;
use App\Http\Controllers\EventController;
// Public routes
Route::post('/login', [AuthController::class, 'login']);
// Kiosk endpoint
Route::post('/kiosk/submit', [\App\Http\Controllers\KioskController::class, 'submit']);
//register 
Route::post('/register', [AuthController::class, 'register']);

Route::apiResource('streets', StreetController::class);

Route::apiResource('events', EventController::class);

Route::get('/public-events', [EventController::class, 'publicIndex']);
// // Handle preflight requests
// Route::options('/*', function () {
//     return response()->json([], 200);
// });

// All routes - no authentication required
Route::middleware([EnsureTokenIsValid::class])->group(function () {
    Route::get('/getAllUser', [AuthController::class, 'index']);
    Route::get('/users/{id}', [AuthController::class, 'show']);
    Route::put('/users/{id}/permissions', [AuthController::class, 'updatePermissions']);
    Route::get('/me', [AuthController::class, 'me']);
    Route::get('/details', [AuthController::class, 'details']);
    Route::post('/uploadProfileImage', [AuthController::class, 'uploadProfileImage']);
    Route::put('/updateProfile', [AuthController::class, 'updateProfile']);
    Route::apiResource('residents', ResidentController::class);
    Route::apiResource('business-clearances', BarangayBusinessClearanceController::class);
    Route::apiResource('building-clearances', BarangayBuildingClearanceController::class);
    Route::apiResource('barangay-clearances', BarangayClearanceController::class);
    Route::apiResource('barangay-certificates', BarangaCertificateController::class);

    // Ticket system endpoints
    Route::post('/tickets', [\App\Http\Controllers\TicketController::class, 'store']);
    Route::get('/tickets/pending', [\App\Http\Controllers\TicketController::class, 'pending']);
    Route::get('/tickets/now-serving', [\App\Http\Controllers\TicketController::class, 'nowServing']);
    Route::get('/tickets/{ticket}', [\App\Http\Controllers\TicketController::class, 'show']);
    Route::patch('/tickets/{ticket}/status', [\App\Http\Controllers\TicketController::class, 'updateStatus']);
    Route::post('/tickets/{ticket}/remarks', [\App\Http\Controllers\TicketController::class, 'addRemark']);
    Route::post('/tickets/update-by-service/{ticketNumber}', [\App\Http\Controllers\TicketController::class, 'findByTicketNumberAndUpdateStatus']);

    Route::get('/notifications', [\App\Http\Controllers\NotificationController::class, 'index']);

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

    Route::prefix('reports')->group(function () {
        Route::get('/overview', [ReportsController::class, 'getOverview']);
        Route::get('/monthly-trends', [ReportsController::class, 'getMonthlyTrends']);
        Route::get('/distribution', [ReportsController::class, 'getDistribution']);
        Route::get('/status-overview', [ReportsController::class, 'getStatusOverview']);
        Route::get('/monthly-comparison', [ReportsController::class, 'getMonthlyComparison']);
    });

    Route::get('/latest-activities', [LatestDashboard::class, 'latestActivity']);
    Route::post('/kiosk/search', [KioskController::class, 'search']);



    Route::get('/check-shell', function() {
        if(function_exists('shell_exec')) {
            return "shell_exec is enabled";
        }
        return "shell_exec is NOT enabled";
    });

    Route::post('/backup/full', [BackupController::class, 'runFullBackup']);
    Route::post('/backup/database', [BackupController::class, 'runDatabaseBackup']);
    Route::post('/backup/files', [BackupController::class, 'runImagesBackup']);

    Route::get('/backup', [BackupController::class, 'listBackups']);
    Route::get('/backup/{id}/download', [BackupController::class, 'downloadBackup']);

    Route::get('/documents', [DocumentController::class, 'index']);
    Route::post('/documents/{document}', [DocumentController::class, 'update']);
    Route::post('/documents', [DocumentController::class, 'store']);
    Route::get('/documents/single/{id}', [DocumentController::class, 'show']);
    Route::put('/documents/{id}/layout', [DocumentController::class, 'updateLayout']);
    // routes/web.php
    Route::get('/documents/{filename}', function ($filename) {
        $path = storage_path('app/public/documents/' . $filename);

        if (!file_exists($path)) {
            abort(404);
        }

        return response()->file($path, [
            'Content-Type' => 'application/pdf',
            'Content-Disposition' => 'inline; filename="' . $filename . '"',
        ]);
    });



    Route::post('/logout', [AuthController::class, 'logout']);
});

