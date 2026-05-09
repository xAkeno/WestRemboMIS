<?php

namespace App\Http\Controllers;

use App\Models\ScheduleSlot;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Carbon\Carbon;
class ScheduleSlotController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | 🟢 LIST ALL SLOTS
    |--------------------------------------------------------------------------
    */
    public function index(Request $request): JsonResponse
    {
        $type = $request->query('document_type');
        $date = $request->query('date');

        $query = ScheduleSlot::orderBy('schedule_time');

        if ($type) {
            $query->where('document_type', $type);
        }

        $slots = $query->get();

        $data = $slots->map(function ($slot) use ($date, $type) {
            $remaining = $slot->max_slots;

            if ($date && $type) {
                $booked = \App\Models\Schedule::where('document_type', $slot->document_type)
                    ->where('schedule_date', $date)          // date filter on schedules ✓
                    ->where('schedule_time', $slot->schedule_time)
                    ->count();

                $remaining = max(0, $slot->max_slots - $booked);
            }

            return array_merge($slot->toArray(), [
                'max_slots' => $remaining,
            ]);
        });

        return response()->json([
            'status' => 'success',
            'data'   => $data,
        ]);
    }

    /*
    |--------------------------------------------------------------------------
    | 🟢 CREATE SLOT (ADMIN)
    |--------------------------------------------------------------------------
    */
    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'document_type' => 'required|string',
            'schedule_time' => 'required|date_format:H:i',
            'max_slots'     => 'required|integer|min:1',
        ]);

        $time = $request->schedule_time;

        // ---------------------------------------------
        // ⛔ FORCE ONLY FULL HOUR
        // ---------------------------------------------
        [$hour, $minute] = explode(':', $time);

        if ((int)$minute !== 0) {
            return response()->json([
                'status' => 'error',
                'message' => 'Only full hour slots allowed (06:00, 07:00, 08:00...)'
            ], 422);
        }

        // ---------------------------------------------
        // ⛔ TIME RANGE CHECK (06:00 - 19:00)
        // ---------------------------------------------
        $current = Carbon::createFromFormat('H:i', $time);
        $min = Carbon::createFromFormat('H:i', '06:00');
        $max = Carbon::createFromFormat('H:i', '19:00');

        if ($current->lt($min) || $current->gt($max)) {
            return response()->json([
                'status' => 'error',
                'message' => 'Schedule slot must be between 06:00 and 19:00 only.'
            ], 422);
        }

        // ---------------------------------------------
        // ❌ NO DUPLICATE SLOT
        // ---------------------------------------------
        $exists = ScheduleSlot::where('document_type', $request->document_type)
            ->where('schedule_time', $time)
            ->exists();

        if ($exists) {
            return response()->json([
                'status' => 'error',
                'message' => 'This schedule time already exists for this document type.'
            ], 422);
        }

        // ---------------------------------------------
        // ⛔ STRICT 1-HOUR GRID VALIDATION
        // (prevents 06:00, 06:01, 06:30 hacks)
        // ---------------------------------------------
        $validSlots = [];
        for ($i = 6; $i <= 19; $i++) {
            $validSlots[] = sprintf('%02d:00', $i);
        }

        if (!in_array($time, $validSlots)) {
            return response()->json([
                'status' => 'error',
                'message' => 'Invalid slot. Only hourly schedule is allowed.'
            ], 422);
        }

        // ---------------------------------------------
        // CREATE SLOT
        // ---------------------------------------------
        $slot = ScheduleSlot::create([
            'document_type' => $request->document_type,
            'schedule_time' => $time,
            'max_slots'     => $request->max_slots,
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'Schedule slot created successfully',
            'data' => $slot
        ], 201);
    }

    /*
    |--------------------------------------------------------------------------
    | 🟢 UPDATE SLOT
    |--------------------------------------------------------------------------
    */
    public function update(Request $request, $id): JsonResponse
    {
        $slot = ScheduleSlot::find($id);

        if (!$slot) {
            return response()->json([
                'status' => 'error',
                'message' => 'Slot not found'
            ], 404);
        }

        $request->validate([
            'schedule_time' => 'sometimes|date_format:H:i',
            'max_slots'     => 'sometimes|integer|min:1',
        ]);

        $time = $request->schedule_time ?? $slot->schedule_time;

        // ---------------------------------------------
        // ⛔ FORCE ONLY FULL HOUR
        // ---------------------------------------------
        [$hour, $minute] = explode(':', $time);

        if ((int)$minute !== 0) {
            return response()->json([
                'status' => 'error',
                'message' => 'Only full hour slots allowed (06:00, 07:00, 08:00...)'
            ], 422);
        }

        // ---------------------------------------------
        // ⛔ TIME RANGE CHECK (06:00 - 19:00)
        // ---------------------------------------------
        $current = Carbon::createFromFormat('H:i', $time);
        $min = Carbon::createFromFormat('H:i', '06:00');
        $max = Carbon::createFromFormat('H:i', '19:00');

        if ($current->lt($min) || $current->gt($max)) {
            return response()->json([
                'status' => 'error',
                'message' => 'Schedule slot must be between 06:00 and 19:00 only.'
            ], 422);
        }

        // ---------------------------------------------
        // ❌ NO DUPLICATE SLOT (ignore current row)
        // ---------------------------------------------
        $exists = ScheduleSlot::where('document_type', $slot->document_type)
            ->where('schedule_time', $time)
            ->where('id', '!=', $slot->id)
            ->exists();

        if ($exists) {
            return response()->json([
                'status' => 'error',
                'message' => 'This schedule time already exists for this document type.'
            ], 422);
        }

        // ---------------------------------------------
        // ⛔ STRICT HOURLY GRID VALIDATION
        // ---------------------------------------------
        $validSlots = [];
        for ($i = 6; $i <= 19; $i++) {
            $validSlots[] = sprintf('%02d:00', $i);
        }

        if (!in_array($time, $validSlots)) {
            return response()->json([
                'status' => 'error',
                'message' => 'Invalid slot. Only hourly schedule is allowed.'
            ], 422);
        }

        // ---------------------------------------------
        // UPDATE SLOT
        // ---------------------------------------------
        $slot->update([
            'schedule_time' => $time,
            'max_slots'     => $request->max_slots ?? $slot->max_slots,
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'Slot updated successfully',
            'data' => $slot
        ]);
    }

    /*
    |--------------------------------------------------------------------------
    | 🟢 DELETE SLOT
    |--------------------------------------------------------------------------
    */
    public function destroy($id): JsonResponse
    {
        $slot = ScheduleSlot::find($id);

        if (!$slot) {
            return response()->json([
                'status' => 'error',
                'message' => 'Slot not found'
            ], 404);
        }

        $slot->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Slot deleted successfully'
        ]);
    }
}