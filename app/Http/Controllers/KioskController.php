<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Http\Requests\KioskSubmitRequest;
use App\Models\Kiosk;
use App\Services\TicketService;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Log;

class KioskController extends Controller
{
    protected TicketService $ticketService;

    public function __construct(TicketService $ticketService)
    {
        $this->ticketService = $ticketService;
    }

    // Kiosk submit persists the kiosk entry and creates a linked ticket.
    public function submit(KioskSubmitRequest $request): JsonResponse
    {
        $data = $request->validated();

        $serviceType = $data['service_type'];
        $priority = $data['priority'] ?? 'Normal';
        // map common fields
        $common = [
            "service_type" => $serviceType,
            'first_name' => $data['first_name'],
            'last_name' => $data['last_name'],
            'middle_name' => $data['middle_name'],
            'authorized_person' => $data['authorized_person'] ?? null,
            'address' => $data['address'],
            'date_of_birth' => $this->normalizeDate($data['date_of_birth']),
            'place_of_birth' => $data['place_of_birth'],
            'period_of_residency' => $data['period_of_residency'],
            'registered_voter' => $data['registered_voter'],
            'house_owner' => $data['house_owner'],
            'relation_to_house_owner' => $data['relation_to_house_owner'],
            'contact_number' => $data['contact_number'],
            'purpose' => $data['purpose'],
            'priority' => "Normal",
        ];

        try {
            $kiosk = Kiosk::create($common);
            

            Log::info('Kiosk submission saved', ['kiosk_id' => $kiosk->id]);

            // Create a ticket linked to this kiosk submission
            try {
                $ticket = $this->ticketService->createTicketForService($kiosk, $serviceType, $priority, null);
                Log::info('Ticket created for kiosk submission', ['kiosk_id' => $kiosk->id, 'ticket_id' => $ticket->id]);
            } catch (\Exception $te) {
                Log::error('Failed to create ticket for kiosk submission', ['kiosk_id' => $kiosk->id, 'error' => $te->getMessage()]);
                $ticket = null;
            }

            return response()->json([
                'kiosk' => $kiosk,
                'ticket' => $ticket,
            ], 201);
        } catch (\Exception $e) {
            Log::error('Kiosk submit failed', ['error' => $e->getMessage(), 'trace' => $e->getTraceAsString()]);

            return response()->json([
                'kiosk' => null,
                'ticket' => null,
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function search(Request $request): JsonResponse
    {
        $request->validate([
            'first_name' => 'required|string|max:255',
            'last_name' => 'required|string|max:255',
            'date_of_birth' => 'required|date',
        ]);

        $firstName = $request->input('first_name');
        $lastName = $request->input('last_name');
        $dob = $this->normalizeDate($request->input('date_of_birth'));

        try {
            $kiosk = Kiosk::where('first_name', 'like', $firstName)
                ->where('last_name', 'like', $lastName)
                ->where('date_of_birth', $dob)
                ->first();

            // if (!$kiosk) {
            //     return response()->json([
            //         'message' => 'No record found for the given details.',
            //         'kiosk' => null,
            //         'ticket' => null
            //     ], 404);
            // }

            // $ticket = $this->ticketService->getTicketByKiosk($kiosk);

            return response()->json([
                'kiosk' => $kiosk,
            ]);
        } catch (\Exception $e) {
            Log::error('Kiosk search failed', ['error' => $e->getMessage(), 'trace' => $e->getTraceAsString()]);

            return response()->json([
                'message' => 'Failed to search for record.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Normalize date input. Accepts dd/mm/yyyy or yyyy-mm-dd and returns yyyy-mm-dd or null.
     */
    protected function normalizeDate(?string $input): ?string
    {
        if (empty($input)) {
            return null;
        }

        if (preg_match('#^(\d{1,2})/(\d{1,2})/(\d{4})$#', $input, $m)) {
            return sprintf('%04d-%02d-%02d', $m[3], $m[2], $m[1]);
        }

        // If already in yyyy-mm-dd format, or any other format, return as-is
        return $input;
    }
}
