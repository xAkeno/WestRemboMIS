<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use App\Models\Setting;

class MaintenanceMode
{
    public function handle(Request $request, Closure $next)
    {
        $maintenance = Setting::where('key', 'maintenance_mode')->value('value');

        $user = $request->user();
        $isAdmin = $user && $user->role === 'ADMIN';

        // ✅ SAFE ROUTE CHECK
        if (
            $request->is('api/settings') ||
            $request->is('api/login') ||
            $request->is('api/logout')
        ) {
            return $next($request);
        }

        // ❌ BLOCK EVERYTHING ELSE
        if ($maintenance === "true" && !$isAdmin) {
            return response()->json([
                'message' => 'System under maintenance'
            ], 503);
        }

        return $next($request);
    }
}