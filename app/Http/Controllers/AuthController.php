<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;
use App\Http\Requests\UpdateUserRequest;
use App\Models\ActivityLogger;
use Illuminate\Support\Facades\Mail;
use App\Mail\VerificationCodeMail;
use Illuminate\Support\Facades\Storage;
use App\Mail\AccountStatusMail;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Illuminate\Support\Facades\Http;
class AuthController extends Controller
{
    /**
     * Register a new user
     */
    public function register(Request $request)
    {
        $request->validate([
            'first_name' => 'required|string|max:255',
            'surname' => 'required|string|max:255',
            'email' => 'required|email:rfc,dns|max:255|unique:users,email',
            'contact' => 'required|regex:/^[0-9+\-() ]+$/|max:20',
            'date_of_birth' => 'required|date',
            'sex' => 'required|in:Male,Female,Other',
            'password' => 'required|string|min:8|confirmed',
            'id_url' => 'required|image|mimes:jpg,jpeg,png|max:2048',
        ]);

        // ---------------- UPLOAD IMAGE ----------------
        $imagePath = null;

        if ($request->hasFile('id_url')) {
            $file = $request->file('id_url');
            $imagePath = Storage::disk('s3')->putFile('ids', $file);
        }

        // ---------------- CREATE IN SUPABASE ----------------
        $supabaseResponse = Http::withHeaders([
            'apikey' => env('SUPABASE_SERVICE_ROLE_KEY'),
            'Authorization' => 'Bearer ' . env('SUPABASE_SERVICE_ROLE_KEY'),
            'Content-Type' => 'application/json',
        ])->post(env('SUPABASE_URL') . '/auth/v1/admin/users', [
            'email' => $request->email,
            'password' => $request->password,
            'email_confirm' => true, // auto-confirm (optional)
        ]);

        if (!$supabaseResponse->successful()) {
            return response()->json([
                'status' => 'failed',
                'message' => 'Failed to create user in Supabase',
                'error' => $supabaseResponse->json()
            ], 500);
        }

        $supabaseUser = $supabaseResponse->json();

        // ---------------- CREATE IN LARAVEL ----------------
        $user = User::create([
            'first_name' => $request->first_name,
            'surname' => $request->surname,
            'email' => $request->email,
            'contact' => $request->contact,
            'sex' => $request->sex,
            'date_of_birth' => $request->date_of_birth,
            'password' => Hash::make($request->password),
            'id_url' => $imagePath,
            'supabase_id' => $supabaseUser['id'] ?? null, // 🔥 IMPORTANT
        ]);

        // ---------------- EMAIL VERIFICATION ----------------
        $code = rand(100000, 999999);

        $user->update([
            'email_verification_code' => $code,
            'email_verification_expires_at' => now()->addMinutes(10),
        ]);

        Mail::to($user->email)->send(new VerificationCodeMail($code));

        return response()->json([
            'status' => 'success',
            'message' => 'Account created successfully (Synced with Supabase)',
            'data' => $user
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

public function supabaseLogin(Request $request)
{
    $request->validate([
        'token' => 'required|string',
    ]);

    $token = $request->token;

    \Log::info('Supabase login attempt', ['token' => $token]);

    try {
        // ✅ Call Supabase to verify token and get user info
        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $token,
            'apikey' => env('SUPABASE_ANON_KEY'), // ✅ add this
        ])->get(env('SUPABASE_URL') . '/auth/v1/user');

        \Log::info('Supabase /user response', ['status' => $response->status(), 'body' => $response->body()]);

        if ($response->failed()) {
            \Log::warning('Supabase token invalid', ['response' => $response->json()]);
            return response()->json([
                'status' => 'failed',
                'message' => 'Invalid Supabase token',
                'error' => $response->json()
            ], 401);
        }

        $supabaseUser = $response->json();
        \Log::info('Supabase user data', $supabaseUser);

        $email = $supabaseUser['email'] ?? null;
        $supabaseId = $supabaseUser['id'] ?? null;

        if (!$email) {
            \Log::warning('Supabase user has no email', ['supabaseUser' => $supabaseUser]);
            return response()->json([
                'status' => 'failed',
                'message' => 'Invalid Supabase user data',
            ], 401);
        }

        // ✅ Find or create user in Laravel
        $user = User::firstOrCreate(
            ['email' => $email],
            [
                'first_name' => $supabaseUser['user_metadata']['first_name'] ?? 'Supabase',
                'surname' => $supabaseUser['user_metadata']['surname'] ?? 'User',
                'password' => bcrypt(str()->random(16)), // dummy password
                'supabase_id' => $supabaseId,
            ]
        );

        \Log::info('Laravel user found or created', ['user_id' => $user->id]);

        // 🔑 Create Laravel Sanctum token
        $sanctumToken = $user->createToken('auth_token')->plainTextToken;

        \Log::info('Sanctum token created', ['token' => $sanctumToken]);

        // ✅ Set cookie (secure=false for localhost)
        $cookie = cookie(
            'auth_token',
            $sanctumToken,
            60 * 24 * 30, // 30 days
            '/',
            null,
            true, // secure=false for localhost
            true,  // httpOnly
            false,
            'None' // SameSite=None allows cross-origin
        );

        return response()->json([
            'status' => 'success',
            'message' => 'Supabase login successful',
            'data' => [
                'user' => $user,
            ],
        ])->withCookie($cookie);

    } catch (\Exception $e) {
        \Log::error('Supabase login error', ['exception' => $e->getMessage()]);
        return response()->json([
            'status' => 'failed',
            'message' => 'An error occurred during login',
            'error' => $e->getMessage(),
        ], 500);
    }
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

    public function setApproval(Request $request, $id)
    {
        $request->validate([
            'is_approved' => 'required|boolean',
            'status' => 'required|string|in:active,inactive',
        ]);

        $user = User::findOrFail($id);

        // Update approval and status
        $user->is_approved = $request->is_approved;
        $user->status = $request->status;
        $user->save();

        // Send email depending on approval
        $emailStatus = $request->is_approved ? 'approved' : 'rejected';
        Mail::to($user->email)->send(new \App\Mail\AccountStatusMail($user, $emailStatus));

        return response()->json([
            'status' => 'success',
            'message' => "User has been {$emailStatus} and notified via email.",
            'data' => $user
        ]);
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

        $workerBaseUrl = env('R2_WORKER_URL');

        // Full address
        $addressParts = array_filter([
            $user->house_block_lot_no,
            $user->street,
            $user->zone_purok,
        ]);
        $fullAddress = implode(', ', $addressParts);

        // Worker URLs
        $photoUrl = $user->url_photo
            ? $workerBaseUrl . '/' . $user->url_photo
            : null;

        $idUrl = $user->id_url
            ? $workerBaseUrl . '/' . $user->id_url
            : null;

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

                'url_photo' => $photoUrl, // ✅ fixed
                'id_url' => $idUrl,       // ✅ IMPORTANT (your ID issue)

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
            'profileImage' => 'required|image|mimes:jpeg,png,jpg,gif,webp|max:3048', // max 2MB
        ]);

        if ($request->hasFile('profileImage')) {
            $file = $request->file('profileImage');
            $path = Storage::disk('s3')->putFile('profile_images', $file); // just the path
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
            'email' => 'required',
            'password' => 'required',
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json([
                'status' => 'failed',
                'message' => 'Invalid credentials'
            ], 401);
        }

        $user->update([
            'status' => 'active',
        ]);

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

        activity_log(
            'User Logged In',
            'login_attempt',
            'Successful login',
            $user
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

        $workerBaseUrl = env('R2_WORKER_URL');
        $photoUrl = $user->url_photo
            ? $workerBaseUrl . '/' . $user->url_photo
            : null;

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

    // ---------------- VERIFY EMAIL ----------------
    public function verifyEmail(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'code' => 'required|digits:6',
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        if ($user->email_verified_at) {
            return response()->json(['message' => 'Email already verified']);
        }

        if ($user->email_verification_code != $request->code || 
            $user->email_verification_expires_at < now()) {
            return response()->json(['message' => 'Invalid or expired code'], 400);
        }

        $user->update([
            'email_verified_at' => now(),
            'email_verification_code' => null,
            'email_verification_expires_at' => null,
        ]);
        return response()->json(['message' => 'Email verified successfully']);
    }

    // ---------------- FORGOT PASSWORD ----------------
    public function forgotPassword(Request $request)
    {
        $request->validate(['email' => 'required|email']);

        $user = User::where('email', $request->email)->first();
        if (!$user) {
            return response()->json(['message' => 'Account not found'], 404);
        }

        $code = rand(100000, 999999); // 6-digit code
        $user->update([
            'password_reset_code' => $code,
            'password_reset_expires_at' => now()->addMinutes(15),
        ]);

        // Send code via email
        Mail::to($user->email)->send(new \App\Mail\VerificationCodeMail($code));

        return response()->json(['message' => 'Password reset code sent to email']);
    }

    // ---------------- RESET PASSWORD WITH CODE ----------------
    public function resetPassword(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'code' => 'required|digits:6',
            'password' => 'required|string|min:6|confirmed',
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user) {
            \Log::warning('Password reset attempt on non-existent email', ['email' => $request->email]);
            return response()->json(['message' => 'Account not found'], 404);
        }

        // Check code validity
        if (
            $user->password_reset_code != $request->code ||
            !$user->password_reset_expires_at ||
            $user->password_reset_expires_at < now()
        ) {
            \Log::warning('Invalid or expired password reset code', [
                'user_id' => $user->id,
                'code_provided' => $request->code,
                'code_expected' => $user->password_reset_code,
            ]);
            return response()->json(['message' => 'Invalid or expired code'], 400);
        }

        // Update Laravel password
        $user->password = Hash::make($request->password);
        $user->password_reset_code = null;
        $user->password_reset_expires_at = null;
        $user->save();

        \Log::info('Password reset in Laravel successful', ['user_id' => $user->id]);

        // ---------------- Sync password to Supabase ----------------
        if ($user->supabase_id) {
            try {
                $supabaseResponse = Http::withHeaders([
                    'apikey' => env('SUPABASE_SERVICE_ROLE_KEY'),
                    'Authorization' => 'Bearer ' . env('SUPABASE_SERVICE_ROLE_KEY'),
                    'Content-Type' => 'application/json',
                ])->put(env('SUPABASE_URL') . '/auth/v1/admin/users/' . $user->supabase_id, [
                    'password' => $request->password,
                ]);

                if (!$supabaseResponse->successful()) {
                    \Log::error('Supabase password update failed', [
                        'user_id' => $user->id,
                        'response' => $supabaseResponse->body(),
                    ]);

                    return response()->json([
                        'message' => 'Password reset in Laravel succeeded, but failed in Supabase',
                        'supabase_error' => $supabaseResponse->json()
                    ], 500);
                }

                \Log::info('Supabase password updated successfully', ['user_id' => $user->id]);
            } catch (\Exception $e) {
                return response()->json([
                    'message' => 'Password reset in Laravel succeeded, but Supabase update threw exception',
                    'error' => $e->getMessage()
                ], 500);
            }
        }

        return response()->json(['message' => 'Password reset successful']);
    }
    // ---------------- RESEND EMAIL VERIFICATION ----------------
    public function resendVerificationCode(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        if ($user->email_verified_at) {
            return response()->json(['message' => 'Email already verified'], 400);
        }

        // Generate new 6-digit code
        $code = rand(100000, 999999);

        $user->update([
            'email_verification_code' => $code,
            'email_verification_expires_at' => now()->addMinutes(10),
        ]);

        Mail::to($user->email)->send(new VerificationCodeMail($code));

        return response()->json([
            'message' => 'New verification code sent successfully'
        ]);
    }
    // ---------------- RESEND PASSWORD RESET CODE ----------------
    public function resendPasswordResetCode(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user) {
            return response()->json(['message' => 'Account not found'], 404);
        }

        // Generate new 6-digit code
        $code = rand(100000, 999999);

        $user->update([
            'password_reset_code' => $code,
            'password_reset_expires_at' => now()->addMinutes(15),
        ]);

        Mail::to($user->email)->send(new \App\Mail\VerificationCodeMail($code));

        return response()->json([
            'message' => 'New password reset code sent successfully'
        ]);
    }





    public function logout(Request $request)
    {
        $user = $request->user();

        if ($user) {
            // Update status safely
            $user->update([
                'status' => 'inactive',
            ]);

            // Delete token only if it exists
            if ($request->user()->currentAccessToken()) {
                $request->user()->currentAccessToken()->delete();
            }
        }

        return response()->json([
            'status' => 'success',
            'message' => 'Logged out successfully',
        ])->withCookie(
            cookie(
                'auth_token',
                '',
                -1,           // Expire immediately
                '/',          // MUST match path
                null,         // MUST match domain
                true,         // MUST match secure
                true,         // httpOnly
                false,
                'None'        // MUST match SameSite
            )
        );
    }


    /**
     * Logout user and revoke token
     */
}

