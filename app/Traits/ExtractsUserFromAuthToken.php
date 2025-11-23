<?php

namespace App\Traits;

use App\Models\User;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Illuminate\Support\Facades\Cookie;

trait ExtractsUserFromAuthToken
{
    /**
     * Extract user ID from auth_token cookie.
     * The cookie stores a JWT token with the user ID encoded.
     * If no valid token or user ID found, returns null.
     */
    protected function getUserIdFromAuthToken()
    {
        try {
            $token = request()->cookie('auth_token');
            if (!$token) {
                return null;
            }

            // If using Laravel Sanctum tokens stored in cookies:
            // Try to find the token in personal_access_tokens and get the tokenable user
            $tokenModel = \Laravel\Sanctum\PersonalAccessToken::findToken($token);
            if ($tokenModel) {
                return $tokenModel->tokenable_id;
            }

            // If using JWT tokens, decode and extract user ID
            try {
                $decoded = JWT::decode($token, new Key(config('app.key'), 'HS256'));
                return $decoded->sub ?? $decoded->user_id ?? null;
            } catch (\Exception $e) {
                // Not a valid JWT, try another approach
            }

            // Fallback: extract from request if user is authenticated
            return auth()->id();
        } catch (\Exception $e) {
            return null;
        }
    }
}
