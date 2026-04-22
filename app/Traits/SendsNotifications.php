<?php

namespace App\Traits;

use App\Models\Notification;

trait SendsNotifications
{
    protected function notify(
        int $userId,
        string $docType,
        string $docNumber,
        string $title,
        string $message,
        string $type
    ): void {
        Notification::create([
            'user_id' => $userId,
            'document_type' => $docType,
            'document_number' => $docNumber,
            'title' => $title,
            'message' => $message,
            'type' => $type,
        ]);
    }
}