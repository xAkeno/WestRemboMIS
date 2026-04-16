<?php

// app/Http/Controllers/SettingController.php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Setting;

class SettingController extends Controller
{
    // GET all settings
    public function index()
    {
        $settings = Setting::pluck('value', 'key');

        return response()->json($settings);
    }

    // UPDATE multiple settings
    public function update(Request $request)
    {
        $data = $request->all();

        foreach ($data as $key => $value) {
            Setting::set($key, $value);
        }

        return response()->json([
            'message' => 'Settings updated successfully'
        ]);
    }

    // OPTIONAL: get single setting
    public function show($key)
    {
        return response()->json([
            'key' => $key,
            'value' => Setting::get($key)
        ]);
    }
}