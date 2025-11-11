<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\BarangayCertificate;
use App\Http\Requests\StoreBarangayCertificateRequest;
use App\Http\Requests\UpdateBarangayCertificateRequest;

class BarangaCertificateController extends Controller
{
    public function index(Request $request){
        try{
            $query = BarangayCertificate::querty();

            $columns = [
                'trans_number', 'bcert_number', 'firstname', 'middle_name', 'surname', 
                'extension', 'house_block_lot_no', 'street', 'zone', 'purpose', 'purpose_details'
            ];

            // Search functionality
            if ($request->has('search')) {
                $search = $request->search;
                $query->where(function ($q) use ($search) {
                    foreach($columns as $col){
                        $q->where($col,"like","{%$search}%");
                    }
                });
            }

            if($request->has('zone')){
                $query->where('zone', $request->request);
            }

            $per_page = $request->get("per_page",15);
            $data = $request->orderBy("created_at","desc")->paginate($per_page);

            return response()->json([
                "status" => "success",
                "message" => "Result are successfully found",
                "data" => $query->$data
            ],200);


        }catch(\Exception $e){
                return response()->json([
                "status" => "error",
                "message" => "An error occurred while getting Barangay Certificate: " . $e->getMessage(),
            ], 500);
        }
    }
    public function store(StoreBarangayCertificateRequest $request){
        try{
            $data = $request->validated();

            $data["created_by"] = auth()->id();
            return response()->json([
                "status" => "success",
                "message" => "Barangay Certificate created successfully",
                "data" => $data,
            ]);
        }catch(\Exception $e){
            return response()->json([
                "status" => "error",
                "message" => "An error occurred while creating Barangay Certificate: " . $e->getMessage(),
            ], 500);
        }
    }

    public function update(UpdateBarangayCertificateRequest $request,BarangaCertificateRequest $barangaCertificateRequest){
        try{
            $data = $request->validated();
            
            $barangaCertificateRequest->update($data);

            return response()->json([
                "status" => "success",
                "messege" => "Sucessfullt updated the certificate",
                "data" => $barangaCertificateRequest->fresh()
            ]);

        }catch(\Exception $e){
            return response()->json([
                "status" => "error",
                "message" => "An error occurred while updating Barangay Certificate: " . $e->getMessage(),
            ], 500);
        }
    }

    public function delete(BarangayCertificate $request){
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
