<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\BarangayCertificate;
use App\Http\Requests\StoreBarangayCertificateRequest;
use App\Http\Requests\UpdateBarangayCertificateRequest;
use Illuminate\Support\Facades\Log;
class BarangaCertificateController extends Controller
{
    public function index(Request $request)
    {
        try {
            $query = BarangayCertificate::query();

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

            // Search functionality
            if ($request->has('search')) {
                $search = $request->search;
                $query->where(function ($q) use ($columns, $search) {
                    foreach ($columns as $col) {
                        $q->orWhere($col, 'like', "%{$search}%");
                    }

                    $q->orWhereRaw("CONCAT_WS(' ',firstname, middle_name, surname) LIKE ?", ["%{$search}%"]);
                });
            }

            // Filter by zone
            if ($request->has('zone')) {
                $query->where('zone', $request->zone);
            }

            // Filter by date
            if ($request->has('filter_date')) {
                $filter = $request->filter_date;

                if ($filter === 'this_week') {
                    $query->whereBetween('created_at', [
                        now()->startOfWeek(),
                        now()->endOfWeek()
                    ]);
                } elseif ($filter === 'this_month') {
                    $query->whereMonth('created_at', now()->month)
                        ->whereYear('created_at', now()->year);
                } elseif ($filter === 'this_year') {
                    $query->whereYear('created_at', now()->year);
                }
            }

            // Filter by from-to dates
            if ($request->has('from') && $request->has('to')) {
                $query->whereBetween('created_at', [
                    $request->from . ' 00:00:00',
                    $request->to . ' 23:59:59'
                ]);
            }

            // Filter by status (commented out for now)
            // if ($request->has('status')) {
            //     $query->where('status', $request->status);
            // }

            $per_page = $request->get("per_page", 15);
            $data = $query->orderBy("created_at", "desc")->paginate($per_page);

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

            $barangaCertificate = BarangayCertificate::create($data);

            return response()->json([
                "status" => "success",
                "message" => "Barangay Certificate created successfully",
                "data" => $barangaCertificate,
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
                'status' => 'required|in:PENDING,RELEASED'
            ]);

            $record = BarangayCertificate::findOrFail($id);
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
