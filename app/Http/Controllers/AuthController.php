<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

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

        return response()->json([
            'status' => 'success',
            'message' => 'Login successful',
        ])->withCookie($cookie);
    }

    public function me(Request $request)
    {
        $user = $request->user();

        if (!$user) {
            return response()->json([
                'status' => 'failed',
                'message' => 'Unauthenticated'
            ], 401);
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



    public function logout(Request $request)
    {
        $user = $request->user();

        // Update status to 'inactive'
        $user->update([
            'status' => 'inactive',
        ]);

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

