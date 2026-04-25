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
use App\Http\Controllers\MyAllRequestsController;
use App\Http\Controllers\ContactController;
use App\Http\Controllers\OfficialController;
use App\Http\Controllers\ServiceController;
use App\Http\Controllers\ContactCmsController;
use App\Http\Controllers\DocumentUploadController;
use App\Http\Controllers\AIController;
use App\Http\Controllers\ScheduleController;
use App\Http\Controllers\DocumentReplyController;
use App\Http\Controllers\OfficialReceiptController;
use App\Http\Controllers\ActivityLogController;
use App\Http\Controllers\ServicePriceController;
use App\Http\Controllers\ReleaseDocumentController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\TicketController;
use App\Http\Controllers\SettingController;
use App\Http\Controllers\NotificationController;

// ─── Public routes ──────────────────────────────────────────────────────────
Route::post('/login', [AuthController::class, 'supabaseLogin']);
Route::post('/verify', [AuthController::class, 'verifyEmail']);
Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
Route::post('/reset-password', [AuthController::class, 'resetPassword']);
Route::post('/resend-verification-code', [AuthController::class, 'resendVerificationCode']);
Route::post('/resend-password-reset-code', [AuthController::class, 'resendPasswordResetCode']);
Route::post('/logout', [AuthController::class, 'logout']);
Route::post('/kiosk/submit', [KioskController::class, 'submit']);
Route::post('/register', [AuthController::class, 'register']);

Route::apiResource('streets', StreetController::class);
Route::apiResource('events', EventController::class);

Route::get('/services', [ServiceController::class, 'index']);
Route::get('/services/{service}', [ServiceController::class, 'show']);
Route::get('/contact', [ContactCmsController::class, 'index']);
Route::get('/public-events', [EventController::class, 'publicIndex']);
Route::post('/contacts', [ContactController::class, 'submit']);
Route::get('/officials', [OfficialController::class, 'index']);
Route::get('/officials/{id}', [OfficialController::class, 'show']);
Route::get('/email/verify/{id}/{hash}', function (EmailVerificationRequest $request) {
    $request->fulfill();
    return response()->json(['message' => 'Email verified successfully']);
})->middleware(['signed'])->name('verification.verify');
Route::post('/email/verification-notification', function (Request $request) {
    $request->user()->sendEmailVerificationNotification();
    return response()->json(['message' => 'Verification link sent']);
})->middleware(['throttle:6,1'])->name('verification.send');
Route::middleware('verified')->get('/dashboard', function () {
    return response()->json(['message' => 'Welcome verified user']);
});
Route::apiResource('barangay-certificates', BarangaCertificateController::class);
Route::get('settings/', [SettingController::class, 'index']);


// ─── Authenticated routes ────────────────────────────────────────────────────
Route::middleware([EnsureTokenIsValid::class])->group(function () {

    Route::get('/create-collection', function () {
        $response = Http::put(env('VECTOR_DB').'/collections/chatbot', [
            "vectors" => ["size" => 768, "distance" => "Cosine"],
        ]);
        return $response->json();
    });

    Route::prefix('settings')->group(function () {
        Route::get('/{key}', [SettingController::class, 'show']);
        Route::post('/update', [SettingController::class, 'update']);
    });

    Route::get('/dashboard', [DashboardController::class, 'index']);
    Route::get('/test-embedding', [AIController::class, 'embedTest']);
    Route::get('/getAllUser', [AuthController::class, 'index']);
    Route::get('/users/{id}', [AuthController::class, 'show']);
    Route::put('/users/{id}/permissions', [AuthController::class, 'updatePermissions']);

    // ── Auth / profile ────────────────────────────────────────────────────────
    Route::get('/me',      [AuthController::class, 'me']);
    Route::get('/details', [AuthController::class, 'details']);
    Route::get('/user',    [AuthController::class, 'user']);  // ← ADDED: id_url + id_url_back as full URLs

    Route::put('/users/{id}/approve', [AuthController::class, 'setApproval']);
    Route::post('/uploadProfileImage', [AuthController::class, 'uploadProfileImage']);
    Route::put('/updateProfile', [AuthController::class, 'updateProfile']);

    Route::apiResource('residents', ResidentController::class);
    Route::apiResource('business-clearances', BarangayBusinessClearanceController::class);
    Route::apiResource('building-clearances', BarangayBuildingClearanceController::class);
    Route::apiResource('barangay-clearances', BarangayClearanceController::class);
    Route::get('/activity-logs', [ActivityLogController::class, 'index']);

    Route::post('documents/release/{documentType}/{id}', [ReleaseDocumentController::class, 'release']);
    Route::get('documents/release/{documentType}/{id}/download', [ReleaseDocumentController::class, 'download']);
    Route::post('documents/verify', [ReleaseDocumentController::class, 'verify']);

    Route::get('/schedules', [ScheduleController::class, 'index']);
    Route::post('/schedules', [ScheduleController::class, 'store']);
    Route::get('/schedules/available-slots', [ScheduleController::class, 'getAvailableSlots']);
    Route::get('/schedules/{document_number}', [ScheduleController::class, 'showByDocumentNumber']);
    Route::put('/schedules/{document_number}/reschedule', [ScheduleController::class, 'reschedule']);

    Route::prefix('documents')->group(function () {
        Route::get('{type}/{id}/replies', [DocumentReplyController::class, 'index']);
        Route::post('{type}/{id}/replies', [DocumentReplyController::class, 'store']);
    });
    Route::put('/schedules/{documentNumber}/reschedule', [ScheduleController::class, 'reschedule']);
    Route::get('/schedules/{document_number}', [ScheduleController::class, 'showByDocumentNumber']);

    Route::get('/documents/pending', [ScheduleController::class, 'getPendingDocuments']);

    Route::get('/contacts', [ContactController::class, 'index']);
    Route::patch('/contacts/{id}/status', [ContactController::class, 'updateStatus']);
    Route::post('/contacts/{id}/reply', [ContactController::class, 'reply']);
    

    Route::post('/tickets', [TicketController::class, 'store']);
    Route::get('/tickets/pending', [TicketController::class, 'pending']);
    Route::get('/tickets/now-serving', [TicketController::class, 'nowServing']);
    Route::get('/tickets/{ticket}', [TicketController::class, 'show']);
    Route::patch('/tickets/{ticket}/status', [TicketController::class, 'updateStatus']);
    Route::post('/tickets/{ticket}/remarks', [TicketController::class, 'addRemark']);
    Route::post('/tickets/update-by-service/{ticketNumber}', [TicketController::class, 'findByTicketNumberAndUpdateStatus']);

    Route::get('/notifications', [NotificationController::class, 'index']);
    Route::patch('/notifications/{id}/read', [NotificationController::class, 'markRead']);
    Route::patch('/notifications/read-all', [NotificationController::class, 'markAllRead']);

    Route::get('/my-all-requests', [MyAllRequestsController::class, 'index']);
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

    Route::post('/officials', [OfficialController::class, 'store']);
    Route::put('/officials/{id}', [OfficialController::class, 'update']);
    Route::delete('/officials/{id}', [OfficialController::class, 'destroy']);

    Route::post('/contact', [ContactCmsController::class, 'store']);
    Route::put('/contact/{id}', [ContactCmsController::class, 'update']);
    Route::delete('/contact/{id}', [ContactCmsController::class, 'destroy']);

    Route::get('/generate-or', [OfficialReceiptController::class, 'generate']);
    Route::post('/or-starting-number', [OfficialReceiptController::class, 'setStartingNumber']);
    Route::get('/official-receipts/by-or', [OfficialReceiptController::class, 'getByOrNumber']);
    Route::patch('/official-receipts/by-or', [OfficialReceiptController::class, 'updateByOrNumber']);
    Route::get('/official-receipts', [OfficialReceiptController::class, 'index']);
    Route::get('/official-receipts/{id}', [OfficialReceiptController::class, 'show']);
    Route::put('/official-receipts/{id}', [OfficialReceiptController::class, 'update']);

    Route::get('/service-prices', [ServicePriceController::class, 'index']);
    Route::put('/service-prices/{type}', [ServicePriceController::class, 'update']);

    Route::prefix('tickets')->group(function () {
        Route::post('/', [TicketController::class, 'store']);
        Route::get('/pending', [TicketController::class, 'pending']);
        Route::get('/now-serving', [TicketController::class, 'nowServing']);
        Route::post('/call-next', [TicketController::class, 'callNext']);
        Route::patch('/{ticket}/status', [TicketController::class, 'updateStatus']);
        Route::post('/{ticket}/move-back', [TicketController::class, 'moveBack']);
        Route::post('/{ticket}/requeue-late', [TicketController::class, 'requeueLate']);
        Route::get('/{ticket}', [TicketController::class, 'show']);
        Route::post('/find/{ticketNumber}', [TicketController::class, 'findByTicketNumberAndUpdateStatus']);
        Route::get('/late', [TicketController::class, 'lateTickets']);
        Route::post('/{ticket}/remarks', [TicketController::class, 'addRemark']);
    });

    Route::get('/check-shell', function () {
        return function_exists('shell_exec') ? "shell_exec is enabled" : "shell_exec is NOT enabled";
    });

    // =========================================================================
    // DOCUMENT UPLOADS — resident's own files
    // ⚠️  All named segments MUST come before wildcard {id} / {filename}
    // ⚠️  This entire block BEFORE the generic DocumentController routes below
    // =========================================================================

    // Primary prefix: /api/mydocuments/*
    Route::prefix('mydocuments')->name('mydocuments.')->group(function () {
        Route::get('/',        [DocumentUploadController::class, 'index'])->name('index');
        Route::post('/upload', [DocumentUploadController::class, 'upload'])->name('upload');
        Route::post('/submit', [DocumentUploadController::class, 'submit'])->name('submit');
        Route::get('/{id}',    [DocumentUploadController::class, 'show'])->name('show');
        Route::delete('/{id}', [DocumentUploadController::class, 'destroy'])->name('destroy');
    });

    // Alias: /api/documents/* → same DocumentUploadController
    Route::get('/documents',         [DocumentUploadController::class, 'index']);
    Route::post('/documents/upload', [DocumentUploadController::class, 'upload']);
    Route::post('/documents/submit', [DocumentUploadController::class, 'submit']);
    Route::delete('/documents/{id}', [DocumentUploadController::class, 'destroy'])
        ->where('id', '[0-9]+');

    // =========================================================================

    Route::post('/backup/database', [BackupController::class, 'runDatabaseBackup']);
    Route::get('/backup', [BackupController::class, 'listBackups']);
    Route::get('/backup/{fileName}/download', [BackupController::class, 'downloadBackup']);
    Route::get('/backup/settings', [BackupController::class, 'getSettings']);
    Route::post('/backup/settings', [BackupController::class, 'saveSettings']);
    Route::post('/backup/restore/{fileName}', [BackupController::class, 'restoreFromFile']);
    Route::post('/backup/restore-upload', [BackupController::class, 'restoreUpload']);
    Route::post('/backup/scheduled', [BackupController::class, 'runScheduledBackup']);

    // ─── DocumentController (admin: templates / layouts) ─────────────────────
    Route::get('/documents/admin',        [DocumentController::class, 'index']);
    Route::post('/documents/admin',       [DocumentController::class, 'store']);
    Route::post('/documents/update/{id}', [DocumentController::class, 'update']);
    Route::get('/documents/single/{id}',  [DocumentController::class, 'show']);
    Route::put('/documents/{id}/layout',  [DocumentController::class, 'updateLayout']);

    Route::post('/services', [ServiceController::class, 'store']);
    Route::put('/services/{service}', [ServiceController::class, 'update']);
    Route::patch('/services/{service}', [ServiceController::class, 'update']);
    Route::delete('/services/{service}', [ServiceController::class, 'destroy']);

    Route::post('barangay-certificates/{id}/disposition', [BarangaCertificateController::class, 'setDisposition']);
    Route::post('barangay-clearances/{id}/disposition', [BarangayClearanceController::class, 'setDisposition']);
    Route::post('barangay-building-clearances/{id}/disposition', [BarangayBuildingClearanceController::class, 'setDisposition']);
    Route::post('barangay-business-clearances/{id}/disposition', [BarangayBusinessClearanceController::class, 'setDisposition']);
    
    // ⚠️  CATCH-ALL — must be the very last route in this group
    Route::get('/documents/{filename}', function ($filename) {
        $path = storage_path('app/public/documents/' . $filename);
        if (!file_exists($path)) abort(404);
        return response()->file($path, [
            'Content-Type'        => 'application/pdf',
            'Content-Disposition' => 'inline; filename="' . $filename . '"',
        ]);
    });
});