<?php
    namespace App\Http\Controllers;
    use Illuminate\Http\Request;
    use app\Models\Resident;
    use app\Models\BarangayBuildingClearance;
    use app\Models\BarangayClearance;
    use app\Models\BarangayBusinessClearance;
    class LatestDashboard extends Controller{

        public function latestActivity(Request $request){
            try{
                $query1 = Resident::query();
                $query2 = BarangaClearance::query();
                $query3 = BarangayBuildingClearance::query();
                $query4 = BarangayBusinessClearance::query();

                $Messege = [];

                if ($query1->isEmppty()){
                    $Messege.push("No resident data found.");
                }
                if ($query2->isEmppty()){
                    $Messege.push("No barangay clearance data found.");
                }
                if ($query3->isEmppty()){
                    $Messege.push("No building clearance data found.");
                }
                if ($query4->isEmppty()){
                    $Messege.push("No business clearance data found.");
                }

                $data;
                
                $query1 = Resident::orderBy('created_at', 'desc')->take(5)->get();
                $query2 = BarangayClearance::orderBy('created_at', 'desc')->take(5)->get();
                $query3 = BarangayBuildingClearance::orderBy('created_at', 'desc')->take(5)->get();
                $query4 = BarangayBusinessClearance::orderBy('created_at', 'desc')->take(5)->get();

                $date = $query1->concat($query2)->concat($query3)->concat($query4);

                $latest = $data->sortByDesc('created_at')->values()->take(4);
                return response()->json([
                    "status" => "success",
                    "message" => "Latest activities retrieved successfully",
                    "data" => $latest,
                ]);
            }catch(\Exception $e){
                return response()->json([
                    "status" => "error",
                    "message" => "An error occurred while retrieving latest activities: " . $e->getMessage(),
                ], 500);
            }
        }
    }
?>