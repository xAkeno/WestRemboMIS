<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreResidentRequest;
use App\Http\Requests\UpdateResidentRequest;
use App\Models\Resident;
use App\Services\TicketService;
use App\Traits\ExtractsUserFromAuthToken;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use App\Models\Ticket;
use App\Models\ActivityLogger;

class ResidentController extends Controller
{
    use ExtractsUserFromAuthToken;

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = Resident::query();

        if ($request->filled('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('surname', 'like', "%{$search}%")
                  ->orWhere('first_name', 'like', "%{$search}%")
                  ->orWhere('resident_id', 'like', "%{$search}%")
                  ->orWhere('zone', 'like', "%{$search}%");
            });
        }

        if ($request->filled('zone')) {
            $query->where('zone', $request->zone);
        }

        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }

        if ($request->filled('filter_date')) {
            switch ($request->filter_date) {
                case 'this_week':
                    $query->whereBetween('created_at', [now()->startOfWeek(), now()->endOfWeek()]);
                    break;
                case 'this_month':
                    $query->whereMonth('created_at', now()->month)
                          ->whereYear('created_at', now()->year);
                    break;
                case 'this_year':
                    $query->whereYear('created_at', now()->year);
                    break;
            }
        }

        if ($request->filled('from') && $request->filled('to')) {
            $query->whereBetween('created_at', [
                $request->from . ' 00:00:00',
                $request->to   . ' 23:59:59',
            ]);
        }

        $sortField     = Str::snake($request->get('sortField', 'created_at'));
        $sortDirection = $request->get('sortDirection', 'desc');
        $allowedSorts  = ['created_at', 'surname', 'first_name', 'resident_id', 'zone', 'status'];

        if (! in_array($sortField, $allowedSorts)) {
            $sortField = 'created_at';
        }

        $perPage   = $request->get('pageSize', 15);
        $residents = $query->orderBy($sortField, $sortDirection)->paginate($perPage);

        return response()->json([
            'status'  => 'success',
            'message' => 'Residents retrieved successfully',
            'data'    => $residents,
        ], 200);
    }

    public function chartData(Request $request)
    {
        $filter = $request->filter_date ?? 'month';
        $from   = $request->from ?? null;
        $to     = $request->to   ?? null;

        $query = Resident::query();

        if ($from && $to) {
            $query->whereBetween('created_at', [$from . ' 00:00:00', $to . ' 23:59:59'])
                  ->selectRaw('DATE(created_at) as period, COUNT(*) as count')
                  ->groupBy('period')
                  ->orderBy('period');
        } else {
            if ($filter === 'week') {
                $query->whereBetween('created_at', [now()->startOfWeek(), now()->endOfWeek()])
                      ->selectRaw('DAYOFWEEK(created_at) as day_num, DAYNAME(created_at) as period, COUNT(*) as count')
                      ->groupBy('day_num', 'period')
                      ->orderBy('day_num');
            } elseif ($filter === 'month') {
                $query->whereMonth('created_at', now()->month)
                      ->whereYear('created_at', now()->year)
                      ->selectRaw('DAY(created_at) as period, COUNT(*) as count')
                      ->groupBy('period')
                      ->orderBy('period');
            } elseif ($filter === 'year') {
                $query->whereYear('created_at', now()->year)
                      ->selectRaw('MONTH(created_at) as month_num, MONTHNAME(created_at) as period, COUNT(*) as count')
                      ->groupBy('month_num', 'period')
                      ->orderBy('month_num');
            }
        }

        return response()->json([
            'status' => 'success',
            'data'   => $query->get(),
        ]);
    }

    public function total(Request $request)
    {
        return response()->json([
            'status'  => 'success',
            'message' => 'Resident total retrieved successfully',
            'data'    => Resident::count(),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreResidentRequest $request)
    {
        $lastResident = Resident::latest('created_at')->first();
        $lastNumber   = $lastResident ? intval(substr($lastResident->resident_id, 4)) : 0;

        $data                = $request->validated();
        $data['resident_id'] = 'RES-' . str_pad($lastNumber + 1, 3, '0', STR_PAD_LEFT);
        $data['created_by']  = $this->getUserIdFromAuthToken();
        $data['updated_by']  = $this->getUserIdFromAuthToken();

        if ($request->hasFile('photo')) {
            $data['photo'] = $request->file('photo')->store('residents/photos', 'public');
        }

        $resident = Resident::create($data);

        activity_log('Resident Created', 'create', 'Created Resident #: ' . $resident->resident_id);

        // FIX: Kiosk stores the field as `surname`, not `last_name`
        $kiosk = \App\Models\Kiosk::where('service_type', 'Resident Registration')
            ->whereRaw('LOWER(first_name) = ?', [strtolower($data['first_name'])])
            ->whereRaw('LOWER(surname)    = ?', [strtolower($data['surname'])])
            ->first();

        if ($kiosk) {
            Ticket::where('serviceable_type', 'App\\Models\\Kiosk')
                ->where('serviceable_id', $kiosk->id)
                ->whereIn('status', ['pending', 'waiting', 'Pending'])
                ->update(['status' => 'called']);
        }

        return response()->json([
            'status'  => 'success',
            'message' => 'Resident created successfully',
            'data'    => ['service' => $resident, 'ticket' => null],
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Resident $resident)
    {
        return response()->json([
            'status'  => 'success',
            'message' => 'Resident retrieved successfully',
            'data'    => $resident,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateResidentRequest $request, Resident $resident)
    {
        $data = $request->validated();

        if ($request->hasFile('photo')) {
            if ($resident->photo) {
                Storage::disk('public')->delete($resident->photo);
            }
            $data['photo'] = $request->file('photo')->store('residents/photos', 'public');
        }

        $resident->update($data);

        activity_log('Resident Updated', 'update', 'Updated Resident #: ' . $resident->resident_id);

        return response()->json([
            'status'  => 'success',
            'message' => 'Resident updated successfully',
            'data'    => $resident->fresh(),
        ]);
    }

    public function updateStatusResident(Request $request, $id)
    {
        $validated = $request->validate([
            'status' => 'required|in:PENDING,ENCODED,INCOMPLETE,REJECTED,RELEASED,SCHEDULED,EXPIRED,PAID,TO_PAY',
        ]);

        $record = Resident::findOrFail($id);

        $record->status = strtoupper($validated['status']);
        $record->touch();
        $record->save();

        // Map resident status → ticket status
        $ticketStatusMap = [
            'PENDING'  => 'pending',
            'ENCODED'  => 'called',
            'RELEASED' => 'released',
        ];

        $ticketStatus = $ticketStatusMap[strtoupper($validated['status'])] ?? null;

        if ($ticketStatus) {
            $kiosk = \App\Models\Kiosk::where('service_type', 'Resident Registration')
                ->whereRaw('LOWER(first_name) = ?', [strtolower($record->first_name)])
                ->whereRaw('LOWER(surname)    = ?', [strtolower($record->surname)])
                ->first();

            \Log::info('Kiosk lookup for status update', [
                'first_name' => $record->first_name,
                'surname'    => $record->surname,
                'kiosk_id'   => $kiosk?->id,
            ]);

            if ($kiosk) {
                $updated = Ticket::where('serviceable_type', 'App\\Models\\Kiosk')
                    ->where('serviceable_id', $kiosk->id)
                    ->update(['status' => $ticketStatus]);

                \Log::info('Ticket rows updated', ['count' => $updated]);
            }
        }

        activity_log(
            'Resident Status Updated',
            'status_update',
            'Changed to ' . $validated['status'] . ' (Resident #: ' . $record->resident_id . ')'
        );

        return response()->json([
            'status'  => 'success',
            'message' => 'Resident status updated',
            'data'    => $record,
        ], 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Resident $resident)
    {
        if ($resident->photo) {
            Storage::disk('public')->delete($resident->photo);
        }

        $residentId = $resident->resident_id;
        $resident->delete();

        activity_log('Resident Deleted', 'delete', 'Deleted Resident #: ' . $residentId);

        return response()->json([
            'status'  => 'success',
            'message' => 'Resident deleted successfully',
            'data'    => null,
        ]);
    }
}