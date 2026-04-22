<?php
// app/Http/Controllers/QueueController.php

namespace App\Http\Controllers;

use App\Models\Queue;
use App\Models\ResidentRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

class QueueController extends Controller
{
    // ─── ENTRY POINTS ────────────────────────────────────────────────

    /**
     * Add an approved resident to the queue.
     * Called after staff approval or kiosk validation.
     */
    public function addToQueue(Request $request)
    {
        $req = ResidentRequest::findOrFail($request->request_id);

        // Same-day: mark approved_at so the 30-min window can be tracked
        $approvedAt = $req->type === 'same_day' ? now() : null;

        $entry = Queue::create([
            'resident_id'   => $req->resident_id,
            'request_id'    => $req->id,
            'ticket_number' => $this->generateTicketNumber(),
            'type'          => $req->type,
            'status'        => 'waiting',
            'position'      => $this->nextPosition(),
            'approved_at'   => $approvedAt,
            'queue_date'    => today(),
        ]);

        return response()->json($entry, 201);
    }

    // ─── CORE QUEUE OPERATIONS ───────────────────────────────────────

    /**
     * Call the next waiting resident.
     * Sets status to 'called' and records the timestamp.
     */
    public function callNext()
    {
        $next = Queue::where('queue_date', today())
            ->where('status', 'waiting')
            ->orderBy('position')
            ->first();

        if (! $next) {
            return response()->json(['message' => 'Queue is empty'], 200);
        }

        $next->update([
            'status'    => 'called',
            'called_at' => now(),
        ]);

        // Dispatch a job to auto-mark missed after 5 minutes
        \App\Jobs\AutoMarkMissed::dispatch($next->id)
            ->delay(now()->addMinutes(5));

        return response()->json($next);
    }

    /**
     * Skip the current resident — moves them to the back immediately.
     */
    public function skipUser(Queue $queue)
    {
        return $this->moveToBack($queue);
    }

    /**
     * Move a resident to the back of today's queue.
     * Increments missed_attempts; marks no-show if limit exceeded.
     */
    public function moveToBack(Queue $queue)
    {
        $queue->increment('missed_attempts');

        if ($queue->missed_attempts >= 3) {
            return $this->markAsNoShow($queue);
        }

        $queue->update([
            'status'   => 'waiting',
            'position' => $this->nextPosition(),
            'called_at' => null,
        ]);

        return response()->json([
            'message'         => 'Moved to back of queue',
            'missed_attempts' => $queue->missed_attempts,
            'queue'           => $queue->fresh(),
        ]);
    }

    /**
     * Mark a resident as completed.
     */
    public function markAsCompleted(Queue $queue)
    {
        $queue->update([
            'status'     => 'completed',
            'arrived_at' => $queue->arrived_at ?? now(),
        ]);

        return response()->json(['message' => 'Marked as completed', 'queue' => $queue]);
    }

    /**
     * Mark a resident as no-show after 3 missed attempts or full-day absence.
     */
    public function markAsNoShow(Queue $queue)
    {
        $queue->update(['status' => 'no_show']);

        // Notify resident to reschedule (fire-and-forget)
        // Notification::send($queue->resident, new RescheduleReminder($queue));

        return response()->json([
            'message' => 'Marked as no-show. Resident must reschedule.',
            'queue'   => $queue,
        ]);
    }

    /**
     * Accommodate a late resident on the same day.
     * Places them at the back; marks status as 'late'.
     *
     * Same-day rule: if approved_at exists and > 30 min ago, they're late.
     * Scheduled/walk-in: accommodated if still same day.
     */
    public function requeueLateUser(Queue $queue)
    {
        $isLate = false;

        if ($queue->type === 'same_day' && $queue->approved_at) {
            $isLate = now()->diffInMinutes($queue->approved_at) > 30;
        }

        if ($queue->queue_date->isToday()) {
            $queue->update([
                'status'     => $isLate ? 'late' : 'waiting',
                'position'   => $this->nextPosition(),
                'arrived_at' => now(),
            ]);

            return response()->json([
                'message' => $isLate
                    ? 'Late arrival accommodated — placed at back of queue.'
                    : 'Resident requeued.',
                'queue' => $queue->fresh(),
            ]);
        }

        // Not the same day — must reschedule
        return response()->json([
            'message' => 'Resident did not appear today. Must reschedule.',
        ], 422);
    }

    // ─── DISPLAY / POLLING ───────────────────────────────────────────

    /** Current queue state for the display board */
    public function nowServing()
    {
        $called = Queue::where('queue_date', today())
            ->whereIn('status', ['called', 'processing'])
            ->orderBy('position')
            ->first();

        $waiting = Queue::where('queue_date', today())
            ->where('status', 'waiting')
            ->orderBy('position')
            ->get(['id', 'ticket_number', 'type', 'position']);

        return response()->json([
            'now_serving' => $called,
            'upcoming'    => $waiting,
        ]);
    }

    // ─── HELPERS ─────────────────────────────────────────────────────

    private function nextPosition(): int
    {
        return (Queue::where('queue_date', today())->max('position') ?? 0) + 1;
    }

    private function generateTicketNumber(): string
    {
        $prefix = match(now()->dayOfWeek) {
            Carbon::MONDAY    => 'A',
            Carbon::TUESDAY   => 'B',
            Carbon::WEDNESDAY => 'C',
            Carbon::THURSDAY  => 'D',
            default           => 'E',
        };

        $count = Queue::whereDate('created_at', today())->count() + 1;

        return $prefix . str_pad($count, 3, '0', STR_PAD_LEFT); // e.g. A001
    }
}