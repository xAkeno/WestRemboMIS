<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;
use App\Http\Requests\UpdateUserRequest;

class AuthController extends Controller
{
    /**
     * Register a new user
     */
    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8|confirmed',
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'username' => $request->username,
            'password' => Hash::make($request->password),
            'permissions' => json_encode($request->permissions),
        ]);

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'status' => 'success',
            'message' => 'User registered successfully',
            'data' => [
                'user' => $user,
                'token' => $token,
            ],
        ], 201);
    }

    public function updateProfile(UpdateUserRequest $request)
    {
        $user = $request->user(); // Get the logged-in user\
        \Log::info($request->all());
        \Log::info($request->validated());


        $user->update($request->validated());

        return response()->json([
            'status' => 'success',
            'message' => 'Profile updated successfully',
            'data' => $user
        ]);
    }




    public function index()
    {
        $users = User::all();

        return response()->json([
            'status' => 'success',
            'data' => $users,
        ]);
    }
    public function updatePermissions(Request $request, $id) {
        $user = User::findOrFail($id);
        $user->permissions = json_encode($request->permissions);
        $user->save();
        return response()->json(['data' => $user]);
    }

    public function show($id)
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'status' => 'failed',
                'message' => 'User not found'
            ], 404);
        }

        return response()->json([
            'status' => 'success',
            'data' => [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'username' => $user->username,
                'role' => $user->role ?? 'Staff', // default role
                'status' => $user->status,
                'phone' => $user->phone ?? '',
                'location' => $user->location ?? '',
                'joinDate' => $user->created_at->format('F d, Y'),
                'lastActive' => $user->updated_at->diffForHumans(),
                'permissions' => $user->permissions ? json_decode($user->permissions) : [],
            ]
        ], 200);
    }
    public function uploadProfileImage(Request $request)
    {
        $user = $request->user(); // Authenticated user

        if (!$user) {
            return response()->json([
                'status' => 'failed',
                'message' => 'Unauthenticated'
            ], 401);
        }

        // Validate the uploaded file
        $request->validate([
            'profileImage' => 'required|image|mimes:jpeg,png,jpg,gif,webp|max:2048', // max 2MB
        ]);

        if ($request->hasFile('profileImage')) {
            $file = $request->file('profileImage');

            // Generate a unique filename
            $filename = time() . '_' . $file->getClientOriginalName();

            // Store the file in 'public/profile_images' directory
            $path = $file->storeAs('profile_images', $filename, 'public');

            // Save the URL or path in the database
            $user->url_photo = $path;
            $user->save();

            return response()->json([
                'status' => 'success',
                'message' => 'Profile image uploaded successfully',
                'data' => [
                    'url_photo' => $path
                ]
            ], 200);
        }

        return response()->json([
            'status' => 'failed',
            'message' => 'No file uploaded'
        ], 400);
    }



    /**
     * Login user and return token
     */
    public function login(Request $request)
    {
        $request->validate([
            'username' => 'required',
            'password' => 'required',
        ]);

        $user = User::where('username', $request->username)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json([
                'status' => 'failed',
                'message' => 'Invalid credentials'
            ], 401);
        }

        // $user->update([
        //     'status' => 'active',
        // ]);

        $token = $user->createToken('auth_token')->plainTextToken;

        // Fixed cookie for localhost
        $cookie = cookie(
            'auth_token', 
            $token, 
            60*24*30,   // 30 days
            '/',        // path
            null,       // domain null for localhost
            true,      // secure false for local dev
            true,       // httpOnly
            false,      // raw
            'None'       // sameSite safe for local dev
        );

        return response()->json([
            'status' => 'success',
            'message' => 'Login successful',
        ])->withCookie($cookie);
    }

    public function details(Request $request)
    {
        $user = $request->user();

        if (!$user) {
            return response()->json([
                'status' => 'failed',
                'message' => 'Unauthenticated'
            ], 401);
        }

        $addressParts = array_filter([
            $user->house_block_lot_no,
            $user->street,
            $user->zone_purok,
        ]);
        $fullAddress = implode(', ', $addressParts);

        $url = $user->url_photo ? asset('storage/' . $user->url_photo) : null;


        return response()->json([
            'status' => 'success',
            'data' => [
                'id' => $user->id,
                'prefix' => $user->prefix,
                'first_name' => $user->first_name,
                'middle_name' => $user->middle_name,
                'surname' => $user->surname,
                'extension_name' => $user->extension_name,
                'nickname' => $user->nickname,
                'sex' => $user->sex,
                'marital_status' => $user->marital_status,
                'name_of_spouse' => $user->name_of_spouse,
                'date_of_birth' => $user->date_of_birth,
                'url_photo' => $user->url_photo,
                'place_of_birth' => $user->place_of_birth,
                'religion' => $user->religion,
                'email' => $user->email,
                'contact_number' => $user->contact_number,
                'address' => $fullAddress,
                'house_owner' => $user->house_owner,
                'relationship_to_owner' => $user->relationship_to_owner,
                'resident_status' => $user->resident_status,
                'period_of_residency' => $user->period_of_residency,
                'voter_status' => $user->voter_status,
                'precinct_no' => $user->precinct_no,
                'employment_status' => $user->employment_status,
                'occupation' => $user->occupation,
                'position' => $user->position,
                'pwd_status' => (bool) $user->pwd_status,
                'height_cm' => $user->height_cm,
                'weight_kg' => $user->weight_kg,
                'blood_type' => $user->blood_type,
                'complexion' => $user->complexion,
                'username' => $user->username,
                'role' => $user->role ?? 'Staff',
                'status' => $user->status,
                'joinDate' => $user->created_at ? $user->created_at->format('F d, Y') : null,
                'lastActive' => $user->updated_at ? $user->updated_at->diffForHumans() : null,
                'permissions' => $user->permissions ? json_decode($user->permissions) : [],
            ]
        ], 200);
    }

    public function me(Request $request)
    {
        $user = $request->user(); // Authenticated user

        if (!$user) {
            return response()->json([
                'status' => 'failed',
                'message' => 'Unauthenticated'
            ], 401);
        }

        // Build full name
        $nameParts = array_filter([
            $user->prefix,
            $user->first_name,
            $user->middle_name,
            $user->surname,
            $user->extension_name
        ]);
        $fullName = implode(' ', $nameParts);

        return response()->json([
            'status' => 'success',
            'data' => [
                'id' => $user->id,
                'name' => $fullName,
                'url_photo' => $user->url_photo,
                'role' => $user->role ?? 'Staff',
                'permissions' => $user->permissions ? json_decode($user->permissions) : [],
                'status' => $user->status,
            ]
        ], 200);
    }




    public function logout(Request $request)
    {
        $user = $request->user();

        // // Update status to 'inactive'
        // $user->update([
        //     'status' => 'inactive',
        // ]);

        // Delete current access token
        $user->currentAccessToken()->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Logged out successfully',
        ]);
    }


    /**
     * Logout user and revoke token
     */
}

