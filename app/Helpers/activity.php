<?php
use App\Models\ActivityLogger;

if (!function_exists('activity_log')) {

    function activity_log($action, $type = 'other', $description = null, $user = null)
    {
        if (!$user) {
            try {
                $userId = null;

                // 1. Try reading from the auth_token cookie
                $token = request()->cookie('auth_token');
                if ($token) {
                    $tokenModel = \Laravel\Sanctum\PersonalAccessToken::findToken($token);
                    if ($tokenModel) {
                        $userId = $tokenModel->tokenable_id;
                    }
                }

                // 2. Try Authorization header (Bearer token) — for API clients
                if (!$userId) {
                    $bearerToken = request()->bearerToken();
                    if ($bearerToken) {
                        $tokenModel = \Laravel\Sanctum\PersonalAccessToken::findToken($bearerToken);
                        if ($tokenModel) {
                            $userId = $tokenModel->tokenable_id;
                        }
                    }
                }

                // 3. Fallback to Laravel auth
                if (!$userId) {
                    $userId = auth()->id();
                }

                $user = $userId ? \App\Models\User::find($userId) : null;

            } catch (\Throwable $e) {
                $user = null;
            }
        }

        $name = $user
            ? trim(($user->firstname ?? '') . ' ' . ($user->surname ?? ''))
            : 'Guest';

        ActivityLogger::create([
            'user_id'    => $user?->id,
            'user_name'  => $name ?: 'Guest',
            'user_email' => $user?->email ?? 'Guest',
            'action'     => $action,
            'type'       => $type,
            'description'=> $description,
            'ip_address' => request()->ip(),
        ]);
    }
}