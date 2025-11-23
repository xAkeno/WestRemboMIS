<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreTicketRequest;
use App\Http\Requests\UpdateTicketStatusRequest;
use App\Http\Requests\StoreRemarkRequest;
use App\Models\Ticket;
use App\Models\Remark;
use App\Services\TicketService;
use App\Services\NotificationService;
use App\Services\ActivityLogService;
use App\Http\Resources\TicketResource;
use App\Http\Resources\NotificationResource;
use Illuminate\Http\Request;

class TicketController extends Controller
{
    protected $ticketService;
    protected $notificationService;
    protected $logService;

    public function __construct(TicketService $ticketService, NotificationService $notificationService, ActivityLogService $logService)
    {
        $this->ticketService = $ticketService;
        $this->notificationService = $notificationService;
        $this->logService = $logService;
    }

    public function store(StoreTicketRequest $request)
    {
        $data = $request->validated();
        $requesterId = $data['requester_id'] ?? null;
        $ticket = $this->ticketService->createTicket($data, $requesterId);

        // create notification for requester if present
        if ($requesterId) {
            $this->notificationService->createNotification($requesterId, "New ticket {$ticket->ticket_number} created", 'new_ticket');
        }

        return (new TicketResource($ticket))->response()->setStatusCode(201);
    }

    public function pending(Request $request)
    {
        $query = Ticket::query();

        // filters
        if ($request->has('service_type')) {
            $query->where('service_type', $request->service_type);
        }
        if ($request->has('status')) {
            $query->where('status', $request->status);
        }
        if ($request->has('from') && $request->has('to')) {
            $query->whereBetween('submitted_at', [$request->from, $request->to]);
        }
        if ($request->has('search')) {
            $s = $request->search;
            $query->where(function ($q) use ($s) {
                $q->where('ticket_number', 'like', "%{$s}%")
                  ->orWhere('service_type', 'like', "%{$s}%");
            });
        }

        $sort = $request->get('sort', 'newest');
        if ($sort === 'oldest') {
            $query->orderBy('submitted_at', 'asc')->orderBy('created_at', 'asc');
        } else {
            $query->orderBy('submitted_at', 'desc')->orderBy('created_at', 'desc');
        }

        $perPage = (int) $request->get('per_page', 15);
        $tickets = $query->paginate($perPage);

        return TicketResource::collection($tickets);
    }
    public function findByTicketNumberAndUpdateStatus(Request $request, $ticketNumber)
    {
        $request->validate([
            'status' => 'required|string',
        ]);

        // Find the ticket using ticket_number
        $ticket = Ticket::where('ticket_number', $ticketNumber)->first();

        if (! $ticket) {
            return response()->json([
                'message' => 'Ticket not found.'.$ticketNumber
            ], 404);
        }

        // Update the ticket status
        $ticket->status = $request->status;
        $ticket->save();

        return new TicketResource($ticket->fresh());
    }



    public function show(Ticket $ticket)
    {
        return new TicketResource($ticket->load(['activityLogs', 'remarks']));
    }

    public function updateStatus(UpdateTicketStatusRequest $request, Ticket $ticket)
    {
        $data = $request->validated();
        $staffId = $data['staff_id'] ?? null;
        $remarks = $data['remarks'] ?? null;

        $this->logService->log($ticket->id, 'status_update_attempt', $ticket->status, $data['status'], $staffId, $remarks);

        $updated = $this->ticketService->changeStatus($ticket, $data['status'], $staffId);

        // notification examples
        if ($updated->status === 'Approved') {
            $this->notificationService->createNotification($updated->requester_id, "Your ticket {$updated->ticket_number} was approved", 'approved');
        }
        if ($updated->status === 'Released') {
            $this->notificationService->createNotification($updated->requester_id, "Your ticket {$updated->ticket_number} was released", 'released');
        }

        return new TicketResource($updated->fresh());
    }

    public function nowServing()
    {
        $ticket = Ticket::where('status', 'Pending')->orderBy('submitted_at', 'asc')->orderBy('created_at', 'asc')->first();
        if (! $ticket) {
            return response()->json(['message' => 'No pending tickets'], 200);
        }

        return new TicketResource($ticket);
    }

    public function addRemark(StoreRemarkRequest $request, Ticket $ticket)
    {
        $data = $request->validated();
        $remark = Remark::create([
            'ticket_id' => $ticket->id,
            'user_id' => $data['user_id'] ?? null,
            'remark' => $data['remark'],
        ]);

        $this->logService->log($ticket->id, 'remark_added', $ticket->status, $ticket->status, $data['user_id'] ?? null, $data['remark']);

        // return remark resource baked inside ticket
        return response()->json(['status' => 'success', 'data' => $remark], 201);
    }
}
