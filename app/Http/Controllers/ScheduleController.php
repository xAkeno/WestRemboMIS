<?php

namespace App\Http\Controllers;

use App\Models\Schedule;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Traits\ExtractsUserFromAuthToken;
use App\Models\ActivityLogger;
class ScheduleController extends Controller
{
    use ExtractsUserFromAuthToken;

    // 🟢 Dynamic available slots based on document type
    public function getAvailableSlots(Request $request): JsonResponse
    {
        $type = $request->document_type;
        $date = $request->date;

        $slotsConfig = [
            'barangay_clearance'  => ['08:00', '09:00', '10:00'],
            'business_clearance'  => ['10:00', '11:00', '13:00'],
            'building_clearance'  => ['13:00', '14:00', '15:00'],
            'barangay_certificate'=> ['09:00', '11:00', '14:00'],
        ];

        $slots = $slotsConfig[$type] ?? [];

        $taken = Schedule::where('document_type', $type)
            ->where('schedule_date', $date)
            ->pluck('schedule_time')
            ->toArray();

        $available = array_values(array_diff($slots, $taken));

        return response()->json([
            'status' => 'success',
            'data'   => $available,
        ]);
    }

    // 🟢 Store schedule — also flips the document status to SCHEDULED
    public function store(Request $request): JsonResponse
    {
        $userId = $this->getUserIdFromAuthToken();
        $request->merge(['user_id' => $userId]);

        $request->validate([
            'user_id'         => 'required|exists:users,id',
            'document_type'   => 'required|string',
            'document_number' => 'required|string',
            'schedule_date'   => 'required|date',
            'schedule_time'   => 'required',
        ]);

        // Prevent duplicate schedule for the same document
        $alreadyScheduled = Schedule::where('document_number', $request->document_number)->exists();
        if ($alreadyScheduled) {
            return response()->json([
                'status'  => 'error',
                'message' => 'This document already has a schedule.',
            ], 422);
        }

        // Prevent slot conflict
        $slotTaken = Schedule::where('document_type', $request->document_type)
            ->where('schedule_date', $request->schedule_date)
            ->where('schedule_time', $request->schedule_time)
            ->exists();

        if ($slotTaken) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Time slot already taken.',
            ], 422);
        }

        $schedule = Schedule::create($request->all());

        activity_log(
            'Schedule Created',
            'create',
            "User #{$userId} created a schedule for document '{$request->document_number}' ({$request->document_type})"
        );

        // ✅ Update the related document's status to SCHEDULED
        $this->updateDocumentStatus($request->document_type, $request->document_number, 'SCHEDULED');

        return response()->json([
            'status' => 'success',
            'data'   => $schedule,
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
            'barangay_clearance' => \App\Models\BarangayClearance::where('status', 'pending')->pluck('bcert_number'),
            'business_clearance' => \App\Models\BarangayBusinessClearance::where('status', 'pending')->pluck('brgy_business_no'),
            'building_clearance' => \App\Models\BarangayBuildingClearance::where('status', 'pending')->pluck('bcert_number'),
            'barangay_certificate' => \App\Models\BarangayCertificate::where('status', 'pending')->pluck('bcert_number'),
            default              => collect([]),
        };

        return response()->json(['data' => $data]);
    }

    // 🟢 Get schedule by document number
    public function showByDocumentNumber(string $documentNumber): JsonResponse
    {
        $schedule = Schedule::where('document_number', $documentNumber)->first();

        if (!$schedule) {
            return response()->json([
                'status'  => 'error',
                'message' => 'No schedule found for this document.',
            ], 404);
        }

        return response()->json([
            'status' => 'success',
            'data'   => $schedule,
        ]);
    }

    // 🟢 Reschedule by document number — also keeps status as SCHEDULED
    public function reschedule(Request $request, string $documentNumber): JsonResponse
    {
        $userId = $this->getUserIdFromAuthToken();

        $request->validate([
            'schedule_date' => 'required|date',
            'schedule_time' => 'required',
        ]);

        // Find existing schedule — admins bypass the user_id check
        $schedule = Schedule::where('document_number', $documentNumber)->first();

        if (!$schedule) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Schedule not found.',
            ], 404);
        }

        // Prevent slot conflict (ignore current record)
        $slotTaken = Schedule::where('document_type', $schedule->document_type)
            ->where('schedule_date', $request->schedule_date)
            ->where('schedule_time', $request->schedule_time)
            ->where('id', '!=', $schedule->id)
            ->exists();

        if ($slotTaken) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Time slot already taken.',
            ], 422);
        }

        $schedule->update([
            'schedule_date' => $request->schedule_date,
            'schedule_time' => $request->schedule_time,
        ]);

        // ✅ Ensure status stays SCHEDULED after a reschedule too
        $this->updateDocumentStatus($schedule->document_type, $documentNumber, 'RESCHEDULED');

        activity_log(
            'Schedule Rescheduled',
            'update',
            "User #{$userId} rescheduled document '{$documentNumber}' to {$request->schedule_date} {$request->schedule_time}"
        );

        return response()->json([
            'status'  => 'success',
            'message' => 'Schedule updated successfully.',
            'data'    => $schedule,
        ]);
    }

    // ─── Private helper — maps document_type slug to its model and number column ──
    private function updateDocumentStatus(string $documentType, string $documentNumber, string $status): void
    {
        $map = [
            'barangay_clearance'    => [\App\Models\BarangayClearance::class,         'bcert_number'],
            'barangay_certificate'  => [\App\Models\BarangayCertificate::class,        'bcert_number'],
            'business_clearance'    => [\App\Models\BarangayBusinessClearance::class,  'brgy_business_no'],
            'building_clearance'    => [\App\Models\BarangayBuildingClearance::class,  'bcert_number'],
            'resident'              => [\App\Models\Resident::class,                   'resident_id'],
            'resident_registration' => [\App\Models\Resident::class,                   'resident_id'],
        ];

        if (!isset($map[$documentType])) {
            \Log::warning("ScheduleController: unknown document_type '{$documentType}', status update skipped.");
            return;
        }

        [$modelClass, $numberColumn] = $map[$documentType];

        $modelClass::where($numberColumn, $documentNumber)
            ->update(['status' => $status]);
    }
}