<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Carbon\Carbon;
use Illuminate\Support\Facades\Mail;
use App\Models\User;
use App\Mail\RequestWarningMail;

use App\Models\BarangayClearance;
use App\Models\BarangayBusinessClearance;
use App\Models\BarangayBuildingClearance;
use App\Models\BarangayCertificate;

class CleanupInactiveRequests extends Command
{
    protected $signature = 'cleanup:requests';
    protected $description = 'Warn users after 14 days and delete inactive requests after 21 days';

    public function handle()
    {
        $this->processModel(BarangayClearance::class);
        $this->processModel(BarangayBusinessClearance::class);
        $this->processModel(BarangayBuildingClearance::class);
        $this->processModel(BarangayCertificate::class);

        $this->info('Cleanup completed.');
    }

    private function processModel($model)
    {
        $warnDate   = now()->subDays(14);
        $deleteDate = now()->subDays(21);

        // 🔶 1. SEND WARNING (ONLY pending / encoded / scheduled)
        $toWarn = $model::whereNull('warning_sent_at')
            ->whereIn('status', ['PENDING', 'ENCODED', 'SCHEDULED', 'TO_PAY'])
            ->where('created_at', '<=', $warnDate)
            ->get();

        foreach ($toWarn as $record) {

            $user = User::where('email', $record->email)->first();

            if ($user) {
                Mail::to($user->email)->send(
                    new RequestWarningMail($record)
                );
            }

            $record->update([
                'warning_sent_at' => now()
            ]);
        }

        // 🔴 2. DELETE AFTER 3 WEEKS (ONLY STILL INACTIVE)
        $model::where('created_at', '<=', $deleteDate)
            ->whereIn('status', ['PENDING', 'ENCODED', 'SCHEDULED', 'TO_PAY'])
            ->delete();
    }
}