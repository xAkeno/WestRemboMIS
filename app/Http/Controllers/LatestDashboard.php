<?php
    namespace App\Http\Controllers;
    use Illuminate\Http\Request;
    use App\Models\Resident;
    use App\Models\BarangayBuildingClearance;
    use App\Models\BarangayClearance;
    use App\Models\BarangayBusinessClearance;
    use App\Models\BarangayCertificate;
    use App\Models\User;
    class LatestDashboard extends Controller{

        public function latestActivity(Request $request)
        {
            try {
                // 1. Get user ID from cookie
                $user = $request->user(); // Laravel Sanctum automatically resolves the user from the token/cookie

                if (!$user) {
                    return response()->json([
                        "status" => "error",
                        "message" => "User not authenticated."
                    ], 401);
                }

                $userId = $user->id;


                $userId = $user->id;

                // 2. Fetch latest records created by this user
                $residents = Resident::where('created_by', $userId)
                    ->orderBy('created_at', 'desc')->take(5)->get();

                $barangayClearances = BarangayClearance::where('created_by', $userId)
                    ->orderBy('created_at', 'desc')->take(5)->get();

                $buildingClearances = BarangayBuildingClearance::where('created_by', $userId)
                    ->orderBy('created_at', 'desc')->take(5)->get();

                $businessClearances = BarangayBusinessClearance::where('created_by', $userId)
                    ->orderBy('created_at', 'desc')->take(5)->get();

                $certificates = BarangayCertificate::where('created_by', $userId)
                    ->orderBy('created_at', 'desc')->take(5)->get();

                // 3. Combine all data
                $combined = collect()
                    ->concat($residents)
                    ->concat($barangayClearances)
                    ->concat($buildingClearances)
                    ->concat($businessClearances)
                    ->concat($certificates);

                // 4. Get latest 4 entries
                $latest = $combined->sortByDesc('created_at')->values()->take(4);

                return response()->json([
                    "status" => "success",
                    "message" => "Latest activities retrieved successfully",
                    "data" => $latest,
                ]);

            } catch (\Exception $e) {
                return response()->json([
                    "status" => "error",
                    "message" => "An error occurred: " . $e->getMessage(),
                ], 500);
            }
        }

    }
?>