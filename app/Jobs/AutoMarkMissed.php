<?php
// app/Jobs/AutoMarkMissed.php

namespace App\Jobs;

use App\Models\Queue;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;

class AutoMarkMissed implements ShouldQueue
{
    use Dispatchable, Queueable;

    public function __construct(public int $queueId) {}

    public function handle(): void
    {
        $entry = Queue::find($this->queueId);

        // Only act if still in 'called' state (hasn't responded yet)
        if ($entry && $entry->status === 'called') {
            app(\App\Http\Controllers\QueueController::class)
                ->moveToBack($entry);
        }
    }
}