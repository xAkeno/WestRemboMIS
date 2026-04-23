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

    /**
     * Kiosk submit — persists the kiosk entry and creates a linked ticket.
     * Address is stored as separate fields: house_block_lot_no, street, zone.
     */
    public function submit(KioskSubmitRequest $request): JsonResponse
    {
        $data = $request->validated();

        $serviceType = $data['service_type'];
        $priority    = $data['priority'] ?? 'Normal';

        // ─── BASE PAYLOAD (COMMON TO ALL) ───────────────────────────────
        $payload = [

            // ─── Service ─────────────────────────────────────────────
            'service_type'   => $serviceType,
            'requester_type' => $data['requester_type'] ?? null,

            // ─── Personal ────────────────────────────────────────────
            'prefix'      => $data['prefix'] ?? null,
            'first_name'  => $data['first_name'],
            'middle_name' => $data['middle_name'] ?? null,
            'surname'     => $data['surname'],
            'ext_name'    => $data['ext_name'] ?? null,

            // ─── Demographics ────────────────────────────────────────
            'sex'             => $data['sex'] ?? null,
            'marital_status'  => $data['marital_status'] ?? null,
            'name_of_spouse'  => $data['name_of_spouse'] ?? null,
            'date_of_birth'   => $this->normalizeDate($data['date_of_birth'] ?? null),
            'place_of_birth'  => $data['place_of_birth'] ?? null,
            'age'             => $data['age'] ?? null,
            'blood_type'      => $data['blood_type'] ?? null,
            'height_cm'       => $data['height_cm'] ?? null,
            'weight_kg'       => $data['weight_kg'] ?? null,
            'complexion'      => $data['complexion'] ?? null,
            'religion'        => $data['religion'] ?? null,

            // ─── Address ─────────────────────────────────────────────
            'house_block_lot_no' => $data['house_block_lot_no'] ?? null,
            'street'             => $data['street'],
            'zone'               => $data['zone'],

            // ─── Residency ───────────────────────────────────────────
            'period_of_residency'   => $data['period_of_residency'] ?? null,
            'registered_voter'      => $data['registered_voter'] ?? null,
            'house_owner'           => $data['house_owner'] ?? null,
            'relationship_to_owner' => $data['relationship_to_owner'] ?? null,

            // ─── Contact ─────────────────────────────────────────────
            'contact_no'    => $data['contact_number'],
            'email' => $data['email'] ?? null,

            // ─── Purpose ─────────────────────────────────────────────
            'purpose'         => $data['purpose'],
            'purpose_details' => $data['purpose_details'] ?? null,

            // ─── Service-Specific ────────────────────────────────────
            'business_name' => $data['business_name'] ?? null,
            'business_type' => $data['business_type'] ?? null,
            'capital'       => $data['capital'] ?? null,
            'establishment' => $data['establishment'] ?? null,
            'bcert_number'  => $data['bcert_number'] ?? null,
            'brgy_business_no' => $data['brgy_business_no'] ?? null,

            // ─── Queue ───────────────────────────────────────────────
            'priority' => $priority,
            'status'   => 'ENCODED',
        ];

        // ─── SERVICE-SPECIFIC FIELDS ───────────────────────────────────

        switch ($serviceType) {

            case 'Business Clearance':
                $payload = array_merge($payload, [
                    'brgy_business_no' => $data['brgy_business_no'] ?? null,
                    'business_name'    => $data['business_name'] ?? null,
                    'business_type'    => $data['business_type'] ?? null,
                    'business_details' => $data['business_details'] ?? null,
                    'capital'          => $data['capital'] ?? null,
                ]);
                break;

            case 'Building Clearance':
                $payload = array_merge($payload, [
                    'bcert_number' => $data['bcert_number'] ?? null,
                    'establishment'=> $data['establishment'] ?? null,
                ]);
                break;

            case 'Barangay Certificate':
                $payload = array_merge($payload, [
                    'bcert_number' => $data['bcert_number'] ?? null,
                    'age'          => $data['age'] ?? null,
                ]);
                break;

            case 'Barangay Clearance':
            default:
                $payload = array_merge($payload, [
                    'bcert_number' => $data['bcert_number'] ?? null,
                ]);
                break;
        }

        try {
            $kiosk = Kiosk::create($payload);

            $ticket = null;

            try {
                $ticket = $this->ticketService->createTicketForService(
                    $kiosk,
                    $serviceType,
                    $priority,
                    null
                );
            } catch (\Exception $te) {
                Log::error('Ticket creation failed', [
                    'error' => $te->getMessage()
                ]);
            }

            return response()->json([
                'kiosk'  => $kiosk,
                'ticket' => $ticket,
            ], 201);

        } catch (\Exception $e) {
            Log::error('Kiosk submit failed', [
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Search for a kiosk record by name + date of birth.
     */
    public function search(Request $request): JsonResponse
    {
        $request->validate([
            'first_name'    => 'required|string|max:255',
            'surname'       => 'required|string|max:255',
            'date_of_birth' => 'required|date',
        ]);

        $firstName = $request->input('first_name');
        $surname   = $request->input('surname');
        $dob       = $this->normalizeDate($request->input('date_of_birth'));

        try {
            $kiosk = Kiosk::where('first_name', 'like', $firstName)
                ->where('surname', 'like', $surname)
                ->where('date_of_birth', $dob)
                ->first();

            return response()->json(['kiosk' => $kiosk]);

        } catch (\Exception $e) {
            Log::error('Kiosk search failed', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString(),
            ]);

            return response()->json([
                'message' => 'Failed to search for record.',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Normalize date — accepts dd/mm/yyyy or yyyy-mm-dd, returns yyyy-mm-dd or null.
     */
    protected function normalizeDate(?string $input): ?string
    {
        if (empty($input)) {
            return null;
        }

        if (preg_match('#^(\d{1,2})/(\d{1,2})/(\d{4})$#', $input, $m)) {
            return sprintf('%04d-%02d-%02d', $m[3], $m[2], $m[1]);
        }

        return $input;
    }
}