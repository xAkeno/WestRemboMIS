<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Schedule;

// Existing sample command
Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote')->hourly();


// ✅ YOUR CRON COMMAND
Artisan::command('cleanup:requests', function () {

    $models = [
        \App\Models\BarangayClearance::class,
        \App\Models\BarangayCertificate::class,
        \App\Models\BarangayBusinessClearance::class,
        \App\Models\BarangayBuildingClearance::class,
    ];

    foreach ($models as $model) {

        // ⚠️ WARNING after 2 weeks
        $model::whereNull('warning_sent_at')
            ->where('last_activity_at', '<=', now()->subWeeks(2))
            ->chunk(50, function ($records) {

                foreach ($records as $record) {

                    // 🔔 Notification
                    \App\Models\Notification::create([
                        'user_id' => $record->created_by,
                        'title'   => 'Request Expiring Soon',
                        'message' => 'Your request will be deleted in 7 days if no action is taken.',
                    ]);

                    // 📧 Email (if exists)
                    if ($record->email) {
                        \Mail::to($record->email)
                            ->send(new \App\Mail\RequestWarningMail($record));
                    }

                    $record->update([
                        'warning_sent_at' => now()
                    ]);
                }
            });

        // 🗑 DELETE after 3 weeks
        $model::where('last_activity_at', '<=', now()->subWeeks(3))
            ->chunk(50, function ($records) {
                foreach ($records as $record) {
                    $record->delete();
                }
            });
    }

    $this->info('Cleanup completed successfully.');

})->purpose('Cleanup inactive requests');


// ✅ SCHEDULE IT HERE
Schedule::command('cleanup:requests')->daily();