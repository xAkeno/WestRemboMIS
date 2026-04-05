<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\BarangayCertificate;
use App\Services\TicketService;
use App\Http\Requests\StoreBarangayCertificateRequest;
use App\Http\Requests\UpdateBarangayCertificateRequest;
use App\Traits\ExtractsUserFromAuthToken;
use Illuminate\Support\Facades\Log;
use App\Models\Ticket;
use Illuminate\Support\Str;
use Carbon\Carbon;
class BarangaCertificateController extends Controller
{
    use ExtractsUserFromAuthToken;
    public function index(Request $request)
    {
        try {
            BarangayCertificate::where('status', 'RELEASED')
                ->whereNotNull('expires_at')
                ->where('expires_at', '<=', Carbon::now())
                ->update(['status' => 'EXPIRED']);
            $query = BarangayCertificate::with([
                'schedule:id,document_number,schedule_date,schedule_time'
            ]);

            $columns = [
                'bcert_number', 
                'prefix', 
                'firstname', 
                'middle_name', 
                'surname', 
                'extension', 
                'house_block_lot_no', 
                'street', 
                'zone', 
                'purpose', 
                'purpose_details',
                'status'
            ];

            // 🔍 Search
            if ($request->filled('search')) {
                $search = $request->search;

                $query->where(function ($q) use ($columns, $search) {
                    foreach ($columns as $col) {
                        $q->orWhere($col, 'like', "%{$search}%");
                    }

                    $q->orWhereRaw(
                        "CONCAT_WS(' ', firstname, middle_name, surname) LIKE ?",
                        ["%{$search}%"]
                    );
                });
            }

            // 📍 Zone
            if ($request->filled('zone')) {
                $query->where('zone', $request->zone);
            }

            // 📍 Status
            if ($request->filled('status')) {
                $query->where('status', $request->status);
            }

            // 📅 Predefined date filters
            if ($request->filled('filter_date')) {
                switch ($request->filter_date) {
                    case 'this_week':
                        $query->whereBetween('created_at', [
                            now()->startOfWeek(),
                            now()->endOfWeek()
                        ]);
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

            // 📅 Custom range
            if ($request->filled('from') && $request->filled('to')) {
                $query->whereBetween('created_at', [
                    $request->from . ' 00:00:00',
                    $request->to . ' 23:59:59'
                ]);
            }

            // 📅 Schedule filter 🔥
            if ($request->filled('schedule_filter')) {

                if ($request->schedule_filter === 'has_schedule') {
                    $query->has('schedule');
                }

                elseif ($request->schedule_filter === 'no_schedule') {
                    $query->doesntHave('schedule');
                }

                else {
                    $query->whereHas('schedule', function ($q) use ($request) {
                        $q->where('schedule_date', $request->schedule_filter);
                    });
                }
            }

            // 🔽 Sorting (SAFE)
            $sortField = Str::snake($request->get('sortField', 'created_at'));
            $sortDirection = $request->get('sortDirection', 'desc');

            $allowedSorts = [
                'created_at',
                'surname',
                'firstname',
                'bcert_number',
                'zone',
                'status'
            ];

            if (!in_array($sortField, $allowedSorts)) {
                $sortField = 'created_at';
            }

            $query->orderBy($sortField, $sortDirection);

            // 📄 Pagination (match frontend)
            $perPage = $request->get("pageSize", 15);

            $data = $query->paginate($perPage);

            return response()->json([
                "status" => "success",
                "message" => "Results successfully retrieved",
                "data" => $data
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                "status" => "error",
                "message" => "An error occurred while getting Barangay Certificates: " . $e->getMessage(),
            ], 500);
        }
    }

    public function chartData(Request $request)
    {
        $filter = $request->filter_date ?? 'this_month';
        $from = $request->from ?? null;
        $to = $request->to ?? null;
        
        $query = BarangayCertificate::query();

        // Custom from-to range
        if ($from && $to) {
            $query->whereBetween('created_at', [
                $from . ' 00:00:00',
                $to . ' 23:59:59'
            ])
            ->selectRaw('DATE(created_at) as period, COUNT(*) as count')
            ->groupBy('period')
            ->orderBy('period');
        } else {
            // Predefined filters
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

        $data = $query->get();

        return response()->json([
            'status' => 'success',
            'data' => $data
        ]);
    }



    public function store(StoreBarangayCertificateRequest $request){
        try{
            $data = $request->validated();
            
            // $data["created_by"] = auth()->id();
            $lastResident = BarangayCertificate::latest('created_at')->first();
            $lastNumber = $lastResident ? intval(substr($lastResident->bcert_number, 6)) : 0;
            $newRecord = 'BCERT-' . str_pad($lastNumber + 1, 3, '0', STR_PAD_LEFT);

            $data["bcert_number"] = $newRecord;
            $data["created_by"] = $this->getUserIdFromAuthToken();
            $data["updated_by"] = $this->getUserIdFromAuthToken();
            $data["status"] = "ENCODED";
            // $data["issued_date"] = now()->toDateString();

            $barangaCertificate = BarangayCertificate::create($data);

            // Find pending ticket for this service type and attach the created service
            $ticketQuery = \App\Models\Ticket::where('service_type', 'Barangay Certificate')->whereNull('serviceable_id');
            $found = null;
            $userId = $this->getUserIdFromAuthToken();
            if ($userId) {
                $found = (clone $ticketQuery)->where('requester_id', $userId)->orderBy('created_at', 'desc')->first();
            }
            if (!$found) {
                $found = $ticketQuery->orderBy('created_at', 'desc')->first();
            }
            if ($found) {
                $found->serviceable_type = \App\Models\BarangayCertificate::class;
                $found->serviceable_id = $barangaCertificate->id;
                $found->status = 'ENCODED';
                $found->save();
            }

            $ticket = null;
            // try {
            //     $ticket = app(TicketService::class)->createTicketForService($barangaCertificate, 'Barangay Certificate', $data['priority'] ?? 'Normal', null);
            //     Log::info('Ticket created for Barangay Certificate', ['ticket_id' => $ticket?->id]);
            // } catch (\Throwable $e) {
            //     Log::error('Ticket creation failed for BarangayCertificate: ' . $e->getMessage(), ['trace' => $e->getTraceAsString()]);
            // }

            return response()->json([
                "status" => "success",
                "message" => "Barangay Certificate created successfully",
                "data" => ['service' => $barangaCertificate, 'ticket' => $ticket],
            ]);
        }catch(\Exception $e){
            return response()->json([
                "status" => "error",
                "message" => "An error occurred while creating Barangay Certificate: " . $e->getMessage(),
            ], 500);
        }
    }

    public function latestRecord(){
        $lastResident = BarangayCertificate::latest('created_at')->first();
        $lastNumber = $lastResident ? intval(substr($lastResident->bcert_number, 6)) : 0;
        $newRecord = 'BCERT-' . str_pad($lastNumber + 1, 3, '0', STR_PAD_LEFT);

        $lastId = BarangayCertificate::latest('id')->first();
        $lastNumber = intval($lastId->id);
        $sum = intval($lastNumber + 1);

        $data = [
            'nextRecord' => $newRecord,
            'nextId' => $sum,
        ];

        return response()->json([
            'status' => "success",
            'message' => "Successfully get the latest",
            'data' => $data,
        ],200);
    }

    public function update(UpdateBarangayCertificateRequest $request, BarangayCertificate $barangayCertificate)
    {
        try {
            $data = $request->validated();

            $barangayCertificate->update($data);

            return response()->json([
                "status" => "success",
                "message" => "Successfully updated the certificate",
                "data" => $barangayCertificate->fresh()
            ]);

        } catch (\Exception $e) {
            return response()->json([
                "status" => "error",
                "message" => "An error occurred while updating Barangay Certificate: " . $e->getMessage(),
            ], 500);
        }
    }

    public function updateStatus(Request $request, $id)
    {
        try {
            $validated = $request->validate([
                'status' => 'required|in:PENDING,ENCODED,INCOMPLETE,REJECTED,RELEASED'
            ]);

            $record = BarangayCertificate::findOrFail($id);
            // ✅ Set issued + expiry
            if ($validated['status'] === 'RELEASED' && !$record->issued_date) {
                $record->issued_date = now();
                $record->expires_at = now()->addMonths(6);
            }
            $record->status = $validated['status'];
            $record->save();

            return response()->json([
                "status" => "success",
                "message" => "Status updated successfully",
                "data" => $record
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                "status" => "error",
                "message" => "Error updating status: " . $e->getMessage(),
            ], 500);
        }
    }


    public function destroy(BarangayCertificate $request){
        try{
            $request->delete();
            return response()->json([
                "status" => "success",
                "message" => "Sucessfullt updated the certificate"
            ],200);
        }catch(\Exception $e){
            return response()->json([
                "status" => "error",
                "message" => "An error occurred while deletting Barangay Certificate: " . $e->getMessage(),
            ], 500);
        }
    }
    
}
