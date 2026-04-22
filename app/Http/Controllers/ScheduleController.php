<?php

namespace App\Http\Controllers;

use App\Models\Schedule;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Traits\ExtractsUserFromAuthToken;
use App\Services\TicketService;

class ScheduleController extends Controller
{
    use ExtractsUserFromAuthToken;

    protected $ticketService;

    const LIMIT_PER_GROUP = 50;

    public function __construct(TicketService $ticketService)
    {
        $this->ticketService = $ticketService;
    }

    /*
    |--------------------------------------------------------------------------
    | 🟢 GET AVAILABLE SLOTS (Morning / Afternoon)
    |--------------------------------------------------------------------------
    */
    public function getAvailableSlots(Request $request): JsonResponse
    {
        $type = $request->document_type;
        $date = $request->date;

        $schedules = Schedule::where('document_type', $type)
            ->where('schedule_date', $date)
            ->get();

        $morningCount = 0;
        $afternoonCount = 0;

        foreach ($schedules as $sched) {
            $group = $this->getTimeGroup($sched->schedule_time);

            if ($group === 'morning') {
                $morningCount++;
            } else {
                $afternoonCount++;
            }
        }

        return response()->json([
            'status' => 'success',
            'data' => [
                'morning' => [
                    'available' => $morningCount < self::LIMIT_PER_GROUP,
                    'remaining' => max(0, self::LIMIT_PER_GROUP - $morningCount)
                ],
                'afternoon' => [
                    'available' => $afternoonCount < self::LIMIT_PER_GROUP,
                    'remaining' => max(0, self::LIMIT_PER_GROUP - $afternoonCount)
                ]
            ]
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
            'time_group'      => 'required|in:morning,afternoon',
        ]);

        // ❌ Prevent duplicate schedule
        if (Schedule::where('document_number', $request->document_number)->exists()) {
            return response()->json([
                'status' => 'error',
                'message' => 'This document already has a schedule.',
            ], 422);
        }

        $group = $request->time_group;

        // ✅ Count how many already in that group
        $count = Schedule::where('document_type', $request->document_type)
            ->where('schedule_date', $request->schedule_date)
            ->get()
            ->filter(fn($s) => $this->getTimeGroup($s->schedule_time) === $group)
            ->count();

        if ($count >= self::LIMIT_PER_GROUP) {
            return response()->json([
                'status' => 'error',
                'message' => ucfirst($group) . ' slot is already full.',
            ], 422);
        }

        // ✅ Auto assign time
        $time = $this->generateTime($group, $count);

        $schedule = Schedule::create([
            'user_id'         => $userId,
            'document_type'   => $request->document_type,
            'document_number' => $request->document_number,
            'schedule_date'   => $request->schedule_date,
            'schedule_time'   => $time,
        ]);

        // 🎟️ Create ticket
        $ticket = $this->ticketService->createTicketForSchedule(
            $schedule,
            $request->document_type,
            $userId
        );

        // 📝 Update document status
        $this->updateDocumentStatus(
            $request->document_type,
            $request->document_number,
            'SCHEDULED'
        );

        return response()->json([
            'status' => 'success',
            'message' => 'Schedule created successfully',
            'data' => [
                'schedule' => $schedule,
                'ticket'   => $ticket,
            ]
        ], 201);
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
            'time_group'    => 'required|in:morning,afternoon',
        ]);

        $schedule = Schedule::where('document_number', $documentNumber)->first();

        if (!$schedule) {
            return response()->json([
                'status' => 'error',
                'message' => 'Schedule not found.',
            ], 404);
        }

        $group = $request->time_group;

        // Count excluding current record
        $count = Schedule::where('document_type', $schedule->document_type)
            ->where('schedule_date', $request->schedule_date)
            ->where('id', '!=', $schedule->id)
            ->get()
            ->filter(fn($s) => $this->getTimeGroup($s->schedule_time) === $group)
            ->count();

        if ($count >= self::LIMIT_PER_GROUP) {
            return response()->json([
                'status' => 'error',
                'message' => ucfirst($group) . ' slot is already full.',
            ], 422);
        }

        $time = $this->generateTime($group, $count);

        $schedule->update([
            'schedule_date' => $request->schedule_date,
            'schedule_time' => $time,
        ]);

        $this->updateDocumentStatus(
            $schedule->document_type,
            $documentNumber,
            'RESCHEDULED'
        );

        return response()->json([
            'status' => 'success',
            'message' => 'Schedule updated successfully.',
            'data' => $schedule,
        ]);
    }

    /*
    |--------------------------------------------------------------------------
    | 🟢 HELPERS
    |--------------------------------------------------------------------------
    */

    private function getTimeGroup(string $time): string
    {
        $hour = intval(substr($time, 0, 2));
        return $hour < 12 ? 'morning' : 'afternoon';
    }

    private function generateTime(string $group, int $index): string
    {
        // Spread evenly every 10 mins

        if ($group === 'morning') {
            // 08:00 - 11:50
            $hour = 8 + floor($index / 6);
            $minute = ($index % 6) * 10;
        } else {
            // 13:00 - 17:50
            $hour = 13 + floor($index / 6);
            $minute = ($index % 6) * 10;
        }

        return sprintf('%02d:%02d', $hour, $minute);
    }
    public function showByDocumentNumber(string $documentNumber)
    {
        $schedule = Schedule::where('document_number', $documentNumber)->first();
        
        if (!$schedule) {
            return response()->json(['message' => 'Schedule not found'], 404);
        }
        
        return response()->json(['status' => 'success', 'data' => $schedule]);
    }

    private function updateDocumentStatus(string $documentType, string $documentNumber, string $status): void
    {
        $map = [
            'barangay_clearance'    => [\App\Models\BarangayClearance::class, 'bcert_number'],
            'barangay_certificate'  => [\App\Models\BarangayCertificate::class, 'bcert_number'],
            'business_clearance'    => [\App\Models\BarangayBusinessClearance::class, 'brgy_business_no'],
            'building_clearance'    => [\App\Models\BarangayBuildingClearance::class, 'bcert_number'],
        ];

        if (!isset($map[$documentType])) return;

        [$model, $column] = $map[$documentType];

        $model::where($column, $documentNumber)
            ->update(['status' => $status]);
    }
}