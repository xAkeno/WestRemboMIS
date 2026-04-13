<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreTicketRequest;
use App\Http\Requests\UpdateTicketStatusRequest;
use App\Http\Requests\StoreRemarkRequest;
use App\Models\Ticket;
use App\Models\Remark;
use App\Services\TicketService;
use App\Services\NotificationService;
use App\Http\Resources\TicketResource;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class TicketController extends Controller
{
    protected $ticketService;
    protected $notificationService;

    public function __construct(
        TicketService $ticketService,
        NotificationService $notificationService
    ) {
        $this->ticketService       = $ticketService;
        $this->notificationService = $notificationService;
    }

    public function store(StoreTicketRequest $request)
    {
        $data        = $request->validated();
        $requesterId = $data['requester_id'] ?? null;

        $ticket = $this->ticketService->createTicket($data, $requesterId);

        if ($requesterId) {
            $this->notificationService->createNotification(
                $requesterId,
                "New ticket {$ticket->ticket_number} created",
                'new_ticket'
            );
        }

        return (new TicketResource($ticket))->response()->setStatusCode(201);
    }

    public function pending(Request $request)
    {
        $activeStatuses = ['pending', 'waiting', 'called', 'processing', 'late'];

        $query = Ticket::query()
            ->whereDate('queue_date', today());

        if ($request->filled('status')) {
            $query->where('status', strtolower($request->status));
        } else {
            $query->whereIn('status', $activeStatuses);
        }

        if ($request->filled('type')) {
            $query->where('type', $request->type);
        }

        if ($request->filled('service_type')) {
            $query->where('service_type', $request->service_type);
        }

        if ($request->filled('search')) {
            $s = $request->search;
            $query->where(function ($q) use ($s) {
                $q->where('ticket_number', 'like', "%{$s}%")
                  ->orWhere('service_type', 'like', "%{$s}%");
            });
        }

        $query->orderByRaw("
            CASE
                WHEN type = 'scheduled' THEN 0
                ELSE 1
            END
        ")
        ->orderByRaw("COALESCE(scheduled_time, '23:59:59') ASC")
        ->orderBy('position', 'asc');

        $tickets = $query
            ->with('serviceable')
            ->paginate((int) $request->get('per_page', 50));

        return TicketResource::collection($tickets);
    }

    public function findByTicketNumberAndUpdateStatus(Request $request, $ticketNumber)
    {
        $request->validate([
            'status' => 'required|string',
        ]);

        $ticket = Ticket::where('ticket_number', $ticketNumber)->first();

        if (! $ticket) {
            return response()->json([
                'message' => 'Ticket not found: ' . $ticketNumber,
            ], 404);
        }

        $updated = match ($request->status) {
            'called'    => $this->ticketService->callNext(),
            'completed' => $this->ticketService->markAsCompleted($ticket),
            'no_show'   => $this->ticketService->markAsNoShow($ticket),
            'pending'   => $this->ticketService->moveToBack($ticket),
            default     => tap($ticket, fn ($t) => $t->update(['status' => $request->status])),
        };

        return new TicketResource(($updated ?? $ticket)->fresh());
    }

    public function show(Ticket $ticket)
    {
        return new TicketResource($ticket->load(['activityLogs', 'remarks']));
    }

    public function updateStatus(UpdateTicketStatusRequest $request, Ticket $ticket)
    {
        $data    = $request->validated();
        $staffId = $data['staff_id'] ?? null;

        $updated = $this->ticketService->changeStatus($ticket, $data['status'], $staffId);

        if ($updated->requester_id) {
            if ($updated->status === 'Approved') {
                $this->notificationService->createNotification(
                    $updated->requester_id,
                    "Your ticket {$updated->ticket_number} was approved",
                    'approved'
                );
            }
            if ($updated->status === 'Released') {
                $this->notificationService->createNotification(
                    $updated->requester_id,
                    "Your ticket {$updated->ticket_number} was released",
                    'released'
                );
            }
            if ($updated->status === 'completed') {
                $this->notificationService->createNotification(
                    $updated->requester_id,
                    "Your ticket {$updated->ticket_number} has been completed",
                    'completed'
                );
            }
        }

        return new TicketResource($updated->fresh());
    }

    public function nowServing(): JsonResponse
    {
        $data = $this->ticketService->nowServing();

        if (! $data['now_serving']) {
            return response()->json([
                'message'  => 'No active ticket being served',
                'upcoming' => $data['upcoming'],
            ], 200);
        }

        return response()->json($data);
    }

    public function callNext(): JsonResponse
    {
        $ticket = $this->ticketService->callNext();

        if (! $ticket) {
            return response()->json(['message' => 'No pending tickets for today'], 200);
        }

        return (new TicketResource($ticket))->response();
    }

    public function moveBack(Request $request, Ticket $ticket): JsonResponse
    {
        $updated = $this->ticketService->moveToBack($ticket);

        return response()->json([
            'message' => "Ticket {$updated->ticket_number} moved to back (attempt #{$updated->missed_attempts}).",
            'data'    => new TicketResource($updated->fresh()),
        ]);
    }

    public function requeueLate(Request $request, Ticket $ticket): JsonResponse
    {
        if ($ticket->status !== 'late') {
            return response()->json([
                'message' => "Ticket {$ticket->ticket_number} is not 'late' (current status: {$ticket->status}).",
            ], 422);
        }

        $updated = $this->ticketService->requeueLateTicket($ticket);

        return response()->json([
            'message' => "Ticket {$updated->ticket_number} re-admitted at position {$updated->position}.",
            'data'    => new TicketResource($updated->fresh()),
        ]);
    }

    public function lateTickets(): JsonResponse
    {
        $tickets = Ticket::whereDate('queue_date', today())
            ->where('status', 'late')
            ->orderBy('missed_attempts', 'desc')
            ->orderBy('called_at', 'desc')
            ->get();

        return response()->json([
            'data' => TicketResource::collection($tickets),
        ]);
    }

    public function addRemark(StoreRemarkRequest $request, Ticket $ticket)
    {
        $data = $request->validated();

        $remark = Remark::create([
            'ticket_id' => $ticket->id,
            'user_id'   => $data['user_id'] ?? null,
            'remark'    => $data['remark'],
        ]);

        return response()->json([
            'status' => 'success',
            'data'   => $remark,
        ], 201);
    }
}