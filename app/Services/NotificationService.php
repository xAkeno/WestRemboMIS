<?php

namespace App\Services;

use App\Models\Notification;

class NotificationService
{
    public function createNotification($userId, $message, $type = null)
    {
        return Notification::create([
            'user_id' => $userId,
            'message' => $message,
            'type' => $type,
        ]);
    }
}
