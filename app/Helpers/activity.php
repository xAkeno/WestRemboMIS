<?php

use App\Models\ActivityLogger;

if (!function_exists('activity_log')) {

    function activity_log($action, $type = 'other', $description = null, $user = null)
    {
        $user = $user ?? auth()->user();
        $name = $user ? $user->name : 'Guest';
        \App\Models\ActivityLogger::create([
            'user_id'   => $user?->id,
            'user_name'  => $name,
            'user_email' => $user?->email ?? 'Guest',
            'action'     => $action,
            'type'       => $type,
            'description'=> $description,
            'ip_address' => request()->ip(),
        ]);
    }

}
?>
