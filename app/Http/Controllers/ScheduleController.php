<?php

namespace App\Http\Controllers;

use App\Models\Schedule;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Traits\ExtractsUserFromAuthToken;
use App\Services\TicketService;
use App\Models\ScheduleSlot;

class ScheduleController extends Controller
{
    use ExtractsUserFromAuthToken;

    protected $ticketService;

    public function __construct(TicketService $ticketService)
    {
        $this->ticketService = $ticketService;
    }

    /*
    |--------------------------------------------------------------------------
    | 🟢 GET AVAILABLE SLOTS
    |--------------------------------------------------------------------------
    */
    public function getAvailableSlots(Request $request): JsonResponse
    {
        $type = $request->document_type;
        $date = $request->date;

        // ✅ No schedule_date filter — schedule_slots has no date column
        $slots = ScheduleSlot::where('document_type', $type)
            ->orderBy('schedule_time')
            ->get();

        $data = [];

        foreach ($slots as $slot) {
            // ✅ Count bookings for this specific date + time
            $count = Schedule::where('document_type', $type)
                ->where('schedule_date', $date)
                ->where('schedule_time', $slot->schedule_time)
                ->count();

            $data[] = [
                'time'             => $slot->schedule_time,
                'max_slots'        => $slot->max_slots,
                'used_slots'       => $count,
                'remaining_slots'  => max(0, $slot->max_slots - $count),
                'available'        => $count < $slot->max_slots,
            ];
        }

        return response()->json([
            'status' => 'success',
            'data'   => $data,
        ]);
    }

    /*
    |--------------------------------------------------------------------------
    | 🟢 STORE SCHEDULE
    |--------------------------------------------------------------------------
    */
    public function store(Request $request): JsonResponse
    {
        $userId = $this->getUserIdFromAuthToken();

        $request->validate([
            'document_type'   => 'required|string',
            'document_number' => 'required|string',
            'schedule_date'   => 'required|date',
            'schedule_time'   => 'required',
        ]);

        // ✅ No schedule_date filter on schedule_slots
        $slot = ScheduleSlot::where('document_type', $request->document_type)
            ->where('schedule_time', $request->schedule_time)
            ->first();

        if (!$slot) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Selected schedule slot does not exist.',
            ], 404);
        }

        // ✅ Count bookings for this specific date + time only
        $count = Schedule::where('document_type', $request->document_type)
            ->where('schedule_date', $request->schedule_date)
            ->where('schedule_time', $request->schedule_time)
            ->count();

        if ($count >= $slot->max_slots) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Selected slot is already full.',
            ], 422);
        }

        $schedule = Schedule::create([
            'user_id'         => $userId,
            'document_type'   => $request->document_type,
            'document_number' => $request->document_number,
            'schedule_date'   => $request->schedule_date,
            'schedule_time'   => $request->schedule_time,
        ]);

        $ticket = $this->ticketService->createTicketForSchedule(
            $schedule,
            $request->document_type,
            $userId
        );

        $this->updateDocumentStatus(
            $request->document_type,
            $request->document_number,
            'SCHEDULED'
        );

        return response()->json([
            'status'  => 'success',
            'message' => 'Schedule created successfully',
            'data'    => [
                'schedule' => $schedule,
                'ticket'   => $ticket,
            ],
        ], 201);
    }

    /*
    |--------------------------------------------------------------------------
    | 🔴 MARK NO SHOW
    |--------------------------------------------------------------------------
    */
    public function markNoShow(string $documentType, string $id): JsonResponse
    {
        $schedule = Schedule::where('id', $id)
            ->where('document_type', $documentType)
            ->first();

        if (!$schedule) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Schedule not found.',
            ], 404);
        }

        $today    = now()->startOfDay();
        $schedDay = \Carbon\Carbon::parse($schedule->schedule_date)->startOfDay();

        if ($schedDay >= $today) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Schedule has not passed yet.',
            ], 422);
        }

        $currentStatus = $this->getCurrentDocumentStatus(
            $schedule->document_type,
            $schedule->document_number
        );

        if (in_array(strtolower($currentStatus ?? ''), ['no_show', 'rescheduled'])) {
            return response()->json([
                'status'  => 'success',
                'message' => 'Status already updated.',
            ]);
        }

        $this->updateDocumentStatus(
            $schedule->document_type,
            $schedule->document_number,
            'NO_SHOW'
        );

        return response()->json([
            'status'  => 'success',
            'message' => 'Marked as no show.',
        ]);
    }

    /*
    |--------------------------------------------------------------------------
    | 🟢 RESCHEDULE
    |--------------------------------------------------------------------------
    */
    public function reschedule(Request $request, string $documentNumber): JsonResponse
    {
        $request->validate([
            'schedule_date' => 'required|date',
            'schedule_time' => 'required',
        ]);

        $schedule = Schedule::where('document_number', $documentNumber)->first();

        if (!$schedule) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Schedule not found.',
            ], 404);
        }

        // ✅ No schedule_date filter on schedule_slots
        $slot = ScheduleSlot::where('document_type', $schedule->document_type)
            ->where('schedule_time', $request->schedule_time)
            ->first();

        if (!$slot) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Selected slot does not exist.',
            ], 404);
        }

        // ✅ Count bookings for this specific date + time, excluding current record
        $count = Schedule::where('document_type', $schedule->document_type)
            ->where('schedule_date', $request->schedule_date)
            ->where('schedule_time', $request->schedule_time)
            ->where('id', '!=', $schedule->id)
            ->count();

        if ($count >= $slot->max_slots) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Selected slot is already full.',
            ], 422);
        }

        $schedule->update([
            'schedule_date' => $request->schedule_date,
            'schedule_time' => $request->schedule_time,
        ]);

        $this->updateDocumentStatus(
            $schedule->document_type,
            $documentNumber,
            'RESCHEDULED'
        );

        return response()->json([
            'status'  => 'success',
            'message' => 'Schedule updated successfully.',
            'data'    => $schedule,
        ]);
    }

    /*
    |--------------------------------------------------------------------------
    | 🟢 SHOW BY DOCUMENT NUMBER
    |--------------------------------------------------------------------------
    */
    public function showByDocumentNumber(string $documentNumber): JsonResponse
    {
        $schedule = Schedule::where('document_number', $documentNumber)->first();

        if (!$schedule) {
            return response()->json(['message' => 'Schedule not found'], 404);
        }

        return response()->json(['status' => 'success', 'data' => $schedule]);
    }

    /*
    |--------------------------------------------------------------------------
    | 🟢 HELPERS
    |--------------------------------------------------------------------------
    */
    private function updateDocumentStatus(string $documentType, string $documentNumber, string $status): void
    {
        $map = [
            'barangay_clearance'   => [\App\Models\BarangayClearance::class,        'bcert_number'],
            'barangay_certificate' => [\App\Models\BarangayCertificate::class,       'bcert_number'],
            'business_clearance'   => [\App\Models\BarangayBusinessClearance::class, 'brgy_business_no'],
            'building_clearance'   => [\App\Models\BarangayBuildingClearance::class, 'bcert_number'],
        ];

        if (!isset($map[$documentType])) return;

        [$model, $column] = $map[$documentType];

        $model::where($column, $documentNumber)
            ->update(['status' => $status]);
    }

    private function getCurrentDocumentStatus(string $documentType, string $documentNumber): ?string
    {
        $map = [
            'barangay_clearance'   => [\App\Models\BarangayClearance::class,        'bcert_number'],
            'barangay_certificate' => [\App\Models\BarangayCertificate::class,       'bcert_number'],
            'business_clearance'   => [\App\Models\BarangayBusinessClearance::class, 'brgy_business_no'],
            'building_clearance'   => [\App\Models\BarangayBuildingClearance::class, 'bcert_number'],
        ];

        if (!isset($map[$documentType])) return null;

        [$model, $column] = $map[$documentType];

        $record = $model::where($column, $documentNumber)->first();

        return $record?->status;
    }
}