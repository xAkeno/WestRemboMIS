<?php

namespace App\Services;

use App\Models\Ticket;
use App\Models\ActivityLog;
use App\Traits\TicketNumberTrait;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class TicketService
{
    use TicketNumberTrait;

    public function createTicket(array $data, $requesterId = null)
    {
        // Wrap service and ticket creation inside a transaction for atomicity
        return DB::transaction(function () use ($data, $requesterId) {
            $serviceType = $data['service_type'] ?? 'Resident Registration';
            $ticketNumber = $this->generateTicketNumber($serviceType);

            // First, create the related service record if service_data is provided
            $serviceable = null;
            $serviceData = $data['service_data'] ?? null;
            // Create the underlying service record without assuming a requester exists
            switch ($serviceType) {
                case 'Business Clearance':
                    if ($serviceData) {
                        $serviceable = \App\Models\BarangayBusinessClearance::create($serviceData);
                    }
                    break;
                case 'Building Clearance':
                    if ($serviceData) {
                        $serviceable = \App\Models\BarangayBuildingClearance::create($serviceData);
                    }
                    break;
                case 'Barangay Clearance':
                    if ($serviceData) {
                        $serviceable = \App\Models\BarangayClearance::create($serviceData);
                    }
                    break;
                case 'Barangay Certificate':
                    if ($serviceData) {
                        $serviceable = \App\Models\BarangayCertificate::create($serviceData);
                    }
                    break;
                case 'Resident Registration':
                default:
                    if ($serviceData) {
                        $serviceable = \App\Models\Resident::create($serviceData);
                    }
                    break;
            }

            $ticket = Ticket::create([
                'ticket_number' => $ticketNumber,
                'service_type' => $serviceType,
                'requester_id' => $requesterId,
                'status' => 'Pending',
                'priority' => $data['priority'] ?? 'Normal',
                'submitted_at' => $data['submitted_at'] ?? Carbon::now(),
                'serviceable_type' => $serviceable ? get_class($serviceable) : null,
                'serviceable_id' => $serviceable ? $serviceable->id : null,
            ]);

            // ActivityLog::create([
            //     'ticket_id' => $ticket->id,
            //     'action' => 'created',
            //     'old_status' => null,
            //     'new_status' => 'Pending',
            //     'staff_id' => null,
            //     'remarks' => 'Ticket created',
            // ]);

            return $ticket;
        });
    }

    /**
     * Create a ticket linked to an existing service record (serviceable)
     * This is transactional and will log the creation.
     *
     * @param \Illuminate\Database\Eloquent\Model $serviceable
     * @param string $serviceType
     * @param string $priority
     * @param int|null $requesterId
     * @return \App\Models\Ticket
     */
    public function createTicketForService($serviceable, string $serviceType, string $priority = 'Normal', $requesterId = null)
    {
        return DB::transaction(function () use ($serviceable, $serviceType, $priority, $requesterId) {
            $ticketNumber = $this->generateTicketNumber($serviceType);

            $ticket = Ticket::create([
                'ticket_number' => $ticketNumber,
                'service_type' => $serviceType,
                'requester_id' => $requesterId,
                'status' => 'Pending',
                'priority' => $priority,
                'submitted_at' => Carbon::now(),
                'serviceable_type' => get_class($serviceable),
                'serviceable_id' => $serviceable->id,
            ]);

            // ActivityLog::create([
            //     'ticket_id' => $ticket->id,
            //     'action' => 'created',
            //     'old_status' => null,
            //     'new_status' => 'Pending',
            //     'staff_id' => null,
            //     'remarks' => 'Ticket created for service record',
            // ]);

            return $ticket;
        });
    }

    public function changeStatus(Ticket $ticket, string $newStatus, $staffId = null)
    {
        $old = $ticket->status;
        $ticket->status = $newStatus;

        $now = Carbon::now();
        if ($newStatus === 'In Progress') {
            $ticket->in_progress_at = $now;
            $ticket->processed_by = $staffId;
        } elseif ($newStatus === 'Approved') {
            $ticket->approved_at = $now;
            $ticket->processed_by = $staffId;
        } elseif ($newStatus === 'Rejected') {
            $ticket->rejected_at = $now;
            $ticket->processed_by = $staffId;
        } elseif ($newStatus === 'Released') {
            $ticket->released_at = $now;
        }

        $ticket->save();

        // ActivityLog::create([
        //     'ticket_id' => $ticket->id,
        //     'action' => 'status_changed',
        //     'old_status' => $old,
        //     'new_status' => $newStatus,
        //     'staff_id' => $staffId,
        //     'remarks' => null,
        // ]);

        // If released, automatically move next pending ticket to In Progress
        if ($newStatus === 'Released') {
            $next = Ticket::where('status', 'Pending')->orderBy('submitted_at', 'asc')->orderBy('created_at', 'asc')->first();
            if ($next) {
                $this->changeStatus($next, 'In Progress', $staffId);
            }
        }

        return $ticket;
    }
}
