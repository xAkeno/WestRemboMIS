<?php

namespace App\Services;

use App\Models\Ticket;
use App\Models\Schedule;
use App\Traits\TicketNumberTrait;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class TicketService
{
    use TicketNumberTrait;

    // =========================================================
    // CONSTANTS
    // =========================================================

    private function normalizeServiceType(string $type): string
    {
        return ucwords(str_replace('_', ' ', strtolower(trim($type))));
    }

    // Minutes a called ticket has before it is auto-moved to the back
    const GRACE_PERIOD_MINUTES = 5;

    // Missed call attempts before a ticket is permanently marked 'late'
    const MAX_MISSED_ATTEMPTS = 3;

    // =========================================================
    // SERVICE TYPE → MODEL MAP
    // =========================================================

    private function serviceModelMap(): array
    {
        return [
            'Business Clearance'   => \App\Models\BarangayBusinessClearance::class,
            'Building Clearance'   => \App\Models\BarangayBuildingClearance::class,
            'Barangay Clearance'   => \App\Models\BarangayClearance::class,
            'Barangay Certificate' => \App\Models\BarangayCertificate::class,
            'Resident Registration'=> \App\Models\Resident::class,
        ];
    }

    // =========================================================
    // CREATE TICKET  (admin manual)
    // =========================================================

    public function createTicket(array $data, $requesterId = null): Ticket
    {
        return DB::transaction(function () use ($data, $requesterId) {

            $serviceType = $this->normalizeServiceType(
                $data['service_type'] ?? 'Resident Registration'
            );
            $ticketNumber = $this->generateTicketNumber($serviceType);
            $serviceData  = $data['service_data'] ?? null;

            $serviceable = null;
            $map = $this->serviceModelMap();

            if ($serviceData && isset($map[$serviceType])) {
                $serviceable = $map[$serviceType]::create($serviceData);
            }

            $ticket = Ticket::create([
                'ticket_number'    => $ticketNumber,
                'service_type'     => $serviceType,
                'requester_id'     => $requesterId,

                // Queue fields — unified status is 'pending'
                'status'           => 'pending',
                'type'             => $data['type'] ?? 'walk_in',
                'priority'         => $data['priority'] ?? 'Normal',
                'submitted_at'     => $data['submitted_at'] ?? Carbon::now(),
                'position'         => $this->nextPosition(),
                'queue_date'       => today(),
                'missed_attempts'  => 0,

                // Service record link
                'serviceable_type' => $serviceable ? get_class($serviceable) : null,
                'serviceable_id'   => $serviceable ? $serviceable->id : null,
            ]);

            return $ticket;
        });
    }

    // =========================================================
    // CREATE TICKET FOR SERVICE  (kiosk — links to existing record)
    // =========================================================

    public function createTicketForService($serviceable, string $serviceType, string $priority = 'Normal', $requesterId = null): Ticket
    {
        return DB::transaction(function () use ($serviceable, $serviceType, $priority, $requesterId) {

            $ticketNumber = $this->generateTicketNumber($serviceType);
            $position     = $this->nextPosition();

            $ticket = Ticket::create([
                'ticket_number'    => $ticketNumber,
                'service_type'     => $serviceType,
                'requester_id'     => $requesterId,

                // Queue fields — unified status is 'pending'
                'status'           => 'pending',
                'type'             => 'walk_in',
                'priority'         => $priority,
                'submitted_at'     => Carbon::now(),
                'position'         => $position,
                'queue_date'       => today(),
                'missed_attempts'  => 0,

                // Service record link
                'serviceable_type' => get_class($serviceable),
                'serviceable_id'   => $serviceable->id,
            ]);

            return $ticket;
        });
    }

    // =========================================================
    // CREATE TICKET FOR SCHEDULE  (online appointment)
    // =========================================================

public function createTicketForSchedule(Schedule $schedule, string $serviceType, $requesterId = null): Ticket
{
    return DB::transaction(function () use ($schedule, $serviceType, $requesterId) {

        // جلوگیری duplicate ticket per schedule
        $existing = Ticket::where('schedule_id', $schedule->id)->first();
        if ($existing) {
            return $existing;
        }

        // ✅ Normalize snake_case → Title Case
        $serviceType = $this->normalizeServiceType($serviceType);

        $ticketNumber = $this->generateTicketNumber($serviceType);

        $serviceable = null;

        // ✅ Use document_type from schedule (THIS IS IMPORTANT)
        $docType   = strtolower($schedule->document_type);
        $docNumber = $schedule->document_number;

        // ✅ MATCH CORRECT TABLE + COLUMN (NO MORE SQL ERRORS)
        switch ($docType) {

            case 'barangay_clearance':
                $serviceable = \App\Models\BarangayClearance::where('bcert_number', $docNumber)->first();
                break;

            case 'business_clearance':
                $serviceable = \App\Models\BarangayBusinessClearance::where('brgy_business_no', $docNumber)->first();
                break;

            case 'barangay_certificate':
                $serviceable = \App\Models\BarangayCertificate::where('bcert_number', $docNumber)->first();
                break;

            case 'building_clearance':
                $serviceable = \App\Models\BarangayBuildingClearance::where('bcert_number', $docNumber)->first();
                break;

            case 'resident_registration':
                $serviceable = \App\Models\Resident::where('resident_id', $docNumber)->first();
                break;

            default:
                $serviceable = null;
                break;
        }

        return Ticket::create([
            'ticket_number'    => $ticketNumber,
            'service_type'     => $serviceType,
            'requester_id'     => $requesterId,

            'status'           => 'pending',
            'type'             => 'scheduled',
            'priority'         => 'Normal',
            'submitted_at'     => now(),

            'position'         => 0, // will be assigned later
            'queue_date'       => $schedule->schedule_date,
            'scheduled_time'   => $schedule->schedule_time,

            'missed_attempts'  => 0,
            'schedule_id'      => $schedule->id,

            // ✅ Proper polymorphic linking
            'serviceable_type' => $serviceable ? get_class($serviceable) : null,
            'serviceable_id'   => $serviceable ? $serviceable->id : null,
        ]);
    });
}

    // =========================================================
    // CHANGE STATUS
    // =========================================================

    /**
     * Handles both flows:
     *
     *   Queue actions  : called | completed | no_show | late | pending
     *   Document flow  : In Progress | Approved | Rejected | Released
     */
    public function changeStatus(Ticket $ticket, string $newStatus, $staffId = null): Ticket
    {
        // ── Queue-action statuses ─────────────────────────────────────
        if (in_array($newStatus, ['called', 'completed', 'no_show', 'late'])) {
            return match ($newStatus) {
                'called'    => $this->callNext() ?? $ticket,
                'completed' => $this->markAsCompleted($ticket),
                'no_show'   => $this->markAsNoShow($ticket),
                'late'      => tap($ticket)->update(['status' => 'late']),
            };
        }

        // FIX: 'pending' via changeStatus — if the ticket is 'late', re-queue it cleanly
        // instead of running moveToBack() which would increment missed_attempts again.
        if ($newStatus === 'pending') {
            if ($ticket->status === 'late') {
                return $this->requeueLateTicket($ticket);
            }
            return $this->moveToBack($ticket);
        }

        // ── Original document-processing flow ─────────────────────────
        $ticket->status = $newStatus;
        $now = Carbon::now();

        if ($newStatus === 'In Progress') {
            $ticket->in_progress_at = $now;
            $ticket->processed_by   = $staffId;
        } elseif ($newStatus === 'Approved') {
            $ticket->approved_at  = $now;
            $ticket->processed_by = $staffId;
        } elseif ($newStatus === 'Rejected') {
            $ticket->rejected_at  = $now;
            $ticket->processed_by = $staffId;
        } elseif ($newStatus === 'Released') {
            $ticket->released_at = $now;
        }

        $ticket->save();

        // On Release, auto-advance next pending ticket
        if ($newStatus === 'Released') {
            $next = Ticket::whereDate('queue_date', today())
                ->where('status', 'pending')
                ->orderByRaw("CASE WHEN type = 'scheduled' THEN 0 ELSE 1 END")
                ->orderBy('scheduled_time')
                ->orderBy('position')
                ->first();

            if ($next) {
                $this->changeStatus($next, 'In Progress', $staffId);
            }
        }

        return $ticket;
    }

    // =========================================================
    // CALL NEXT
    // =========================================================

    public function callNext(): ?Ticket
    {
        return DB::transaction(function () {

            // Expire overdue called tickets first
            $this->expireOverdueCalledTickets();

            $next = Ticket::whereDate('queue_date', today())
                ->where('status', 'pending')
                ->orderByRaw("CASE WHEN type = 'scheduled' THEN 0 ELSE 1 END")
                ->orderBy('scheduled_time')
                ->orderBy('position')
                ->lockForUpdate()
                ->first();

            if (! $next) {
                return null;
            }

            // Assign a real position to scheduled tickets still on placeholder 0
            if ((int) $next->position === 0) {
                $next->position = $this->nextPosition();
            }

            $next->update([
                'status'    => 'called',
                'called_at' => now(),
            ]);

            return $next;
        });
    }

    // =========================================================
    // GRACE PERIOD EXPIRY
    // =========================================================

    public function expireOverdueCalledTickets(): void
    {
        $cutoff = now()->subMinutes(self::GRACE_PERIOD_MINUTES);

        $overdue = Ticket::whereDate('queue_date', today())
            ->where('status', 'called')
            ->where('called_at', '<=', $cutoff)
            ->get();

        foreach ($overdue as $ticket) {
            Log::info("Grace period expired for ticket {$ticket->ticket_number} — moving to back.");
            $this->moveToBack($ticket);
        }
    }

    // =========================================================
    // MOVE TO BACK  (miss tracking → 'late' after MAX_MISSED_ATTEMPTS)
    // =========================================================

    public function moveToBack(Ticket $ticket): Ticket
    {
        $newMissed = $ticket->missed_attempts + 1;

        // At or beyond max misses → mark 'late' and pull from active queue.
        // This also catches re-admitted tickets (missed_attempts preserved) that miss again.
        if ($newMissed >= self::MAX_MISSED_ATTEMPTS) {
            $ticket->update([
                'status'          => 'late',
                'missed_attempts' => $newMissed,
                'position'        => $this->nextPosition(),
                'called_at'       => null,
            ]);

            Log::info("Ticket {$ticket->ticket_number} marked LATE after {$newMissed} missed attempts.");
            return $ticket;
        }

        // Still within allowed misses — re-queue at the back as 'pending'
        $ticket->update([
            'status'          => 'pending',
            'position'        => $this->nextPosition(),
            'missed_attempts' => $newMissed,
            'called_at'       => null,
        ]);

        Log::info("Ticket {$ticket->ticket_number} moved to back (miss #{$newMissed}).");
        return $ticket;
    }

    // =========================================================
    // RE-QUEUE LATE TICKET
    // =========================================================

    public function requeueLateTicket(Ticket $ticket): Ticket
    {
        if ($ticket->status !== 'late') {
            return $ticket;
        }

        $position = $this->nextPosition();

        $ticket->update([
            'status'      => 'pending',
            'position'    => $position,
            // missed_attempts intentionally kept — history is preserved.
            // The next miss will still trigger MAX_MISSED and mark late again.
            'called_at'   => null,
            'requeued_at' => now(),
        ]);

        Log::info("Late ticket {$ticket->ticket_number} re-admitted at position {$position}.");
        return $ticket;
    }

    // =========================================================
    // MARK COMPLETED
    // =========================================================

    public function markAsCompleted(Ticket $ticket): Ticket
    {
        $ticket->update([
            'status'     => 'completed',
            'arrived_at' => now(),
        ]);

        return $ticket;
    }

    // =========================================================
    // MARK NO-SHOW
    // =========================================================

    public function markAsNoShow(Ticket $ticket): Ticket
    {
        $ticket->update(['status' => 'no_show']);
        return $ticket;
    }

    // =========================================================
    // NOW SERVING
    // =========================================================

    /**
     * Returns the currently called/in-progress ticket and the
     * upcoming pending queue for TODAY only.
     */
    public function nowServing(): array
    {
        $this->expireOverdueCalledTickets();

        // 'called', 'In Progress', and 'processing' all count as "now serving"
        $called = Ticket::whereDate('queue_date', today())
            ->whereIn('status', ['called', 'In Progress', 'processing'])
            ->orderBy('called_at')
            ->first();

        $pending = Ticket::whereDate('queue_date', today())
            ->where('status', 'pending')
            ->orderByRaw("CASE WHEN type = 'scheduled' THEN 0 ELSE 1 END")
            ->orderBy('scheduled_time')
            ->orderBy('position')
            ->get(['id', 'ticket_number', 'type', 'position', 'scheduled_time', 'service_type', 'missed_attempts']);

        return [
            'now_serving' => $called,
            'upcoming'    => $pending,
        ];
    }

    // =========================================================
    // HELPER — next queue position for today
    // =========================================================

    private function nextPosition(): int
    {
        return (Ticket::whereDate('queue_date', today())->max('position') ?? 0) + 1;
    }
}