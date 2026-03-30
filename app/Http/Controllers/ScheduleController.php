<?php

namespace App\Http\Controllers;

use App\Models\Schedule;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Traits\ExtractsUserFromAuthToken;

class ScheduleController extends Controller
{
    use ExtractsUserFromAuthToken;

    // 🟢 Dynamic available slots based on document type
    public function getAvailableSlots(Request $request): JsonResponse
    {
        $type = $request->document_type;
        $date = $request->date;

        $slotsConfig = [
            'barangay_clearance' => ['08:00', '09:00', '10:00'],
            'business_clearance' => ['10:00', '11:00', '13:00'],
            'building_clearance' => ['13:00', '14:00', '15:00'],
            'barangay_certificate' => ['09:00', '11:00', '14:00'],
        ];

        $slots = $slotsConfig[$type] ?? [];

        $taken = Schedule::where('document_type', $type)
            ->where('schedule_date', $date)
            ->pluck('schedule_time')
            ->toArray();

        $available = array_values(array_diff($slots, $taken));

        return response()->json([
            'status' => 'success',
            'data' => $available
        ]);
    }

    // 🟢 Store schedule
    public function store(Request $request): JsonResponse
    {
        // ✅ Extract user ID from auth token / cookie
        $userId = $this->getUserIdFromAuthToken();

        $request->merge(['user_id' => $userId]);

        $request->validate([
            'user_id' => 'required|exists:users,id',
            'document_type' => 'required|string',
            'document_number' => 'required|string',
            'schedule_date' => 'required|date',
            'schedule_time' => 'required',
        ]);

        // Prevent duplicate schedule for the same document
        $alreadyScheduled = Schedule::where('document_number', $request->document_number)->exists();
        if ($alreadyScheduled) {
            return response()->json([
                'status' => 'error',
                'message' => 'This document already has a schedule.'
            ], 422);
        }

        // Prevent slot conflict
        $slotTaken = Schedule::where('document_type', $request->document_type)
            ->where('schedule_date', $request->schedule_date)
            ->where('schedule_time', $request->schedule_time)
            ->exists();

        if ($slotTaken) {
            return response()->json([
                'status' => 'error',
                'message' => 'Time slot already taken.'
            ], 422);
        }

        $schedule = Schedule::create($request->all());

        return response()->json([
            'status' => 'success',
            'data' => $schedule
        ]);
    }

    // 🟢 View all schedules
    public function index(): JsonResponse
    {
        return response()->json(Schedule::latest()->get());
    }

    // 🟢 Get pending documents
    public function getPendingDocuments(Request $request): JsonResponse
    {
        $type = $request->document_type;

        $data = match ($type) {
            'barangay_clearance' => \App\Models\BarangayClearance::where('status', 'pending')->pluck('clearance_number'),
            'business_clearance' => \App\Models\BusinessClearance::where('status', 'pending')->pluck('clearance_number'),
            default => collect([]),
        };

        return response()->json(['data' => $data]);
    }

    // 🟢 Get schedule by document number (e.g. BCLEAR-001)
    public function showByDocumentNumber(string $documentNumber): JsonResponse
    {
        $schedule = Schedule::where('document_number', $documentNumber)->first();

        if (!$schedule) {
            return response()->json([
                'status' => 'error',
                'message' => 'No schedule found for this document.'
            ], 404);
        }

        return response()->json([
            'status' => 'success',
            'data' => $schedule
        ]);
    }
    
    // 🟢 Reschedule by document number (e.g. BCLEAR-001)
    public function reschedule(Request $request, string $documentNumber): JsonResponse
    {
        $userId = $this->getUserIdFromAuthToken();

        $request->validate([
            'schedule_date' => 'required|date',
            'schedule_time' => 'required',
        ]);

        // Find existing schedule (secure: only owner can update)
        $schedule = Schedule::where('document_number', $documentNumber)
            ->where('user_id', $userId)
            ->first();

        if (!$schedule) {
            return response()->json([
                'status' => 'error',
                'message' => 'Schedule not found or unauthorized.'
            ], 404);
        }

        // ❌ Prevent slot conflict (ignore current record)
        $slotTaken = Schedule::where('document_type', $schedule->document_type)
            ->where('schedule_date', $request->schedule_date)
            ->where('schedule_time', $request->schedule_time)
            ->where('id', '!=', $schedule->id)
            ->exists();

        if ($slotTaken) {
            return response()->json([
                'status' => 'error',
                'message' => 'Time slot already taken.'
            ], 422);
        }

        // ✅ Update schedule
        $schedule->update([
            'schedule_date' => $request->schedule_date,
            'schedule_time' => $request->schedule_time,
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'Schedule updated successfully.',
            'data' => $schedule
        ]);
    }
}