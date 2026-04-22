<?php

// app/Http/Controllers/SettingController.php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Setting;

class SettingController extends Controller
{
    // GET all settings (vacations returned as raw JSON string; frontend parses it)
    public function index()
    {
        $settings = Setting::pluck('value', 'key');

        return response()->json($settings);
    }

    // UPDATE multiple settings
    // Vacations arrive as a JSON-encoded string under the key "vacations"
    public function update(Request $request)
    {
        $data = $request->all();

        // Validate vacation entries if present
        if (isset($data['vacations'])) {
            $decoded = json_decode($data['vacations'], true);

            if (!is_array($decoded)) {
                return response()->json(['message' => 'Invalid vacations payload'], 422);
            }

            // Re-encode cleanly before storing
            $data['vacations'] = json_encode($decoded, JSON_UNESCAPED_UNICODE);
        }

        foreach ($data as $key => $value) {
            Setting::set($key, $value);
        }

        return response()->json(['message' => 'Settings updated successfully']);
    }

    // GET single setting
    public function show($key)
    {
        $value = Setting::get($key);

        // Auto-decode JSON values (like vacations) for convenience
        $decoded = json_decode($value, true);

        return response()->json([
            'key'   => $key,
            'value' => $decoded ?? $value,
        ]);
    }

    // GET all active vacations (useful for middleware / storefront checks)
    public function activeVacations()
    {
        $raw      = Setting::get('vacations', '[]');
        $all      = json_decode($raw, true) ?? [];
        $today    = now()->toDateString();

        $active = array_values(array_filter($all, function ($v) use ($today) {
            return !empty($v['active'])
                && (!empty($v['start']) && $v['start'] <= $today)
                && (!empty($v['end'])   && $v['end']   >= $today);
        }));

        return response()->json($active);
    }
}