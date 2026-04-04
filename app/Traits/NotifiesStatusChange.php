<?php

namespace App\Traits;

use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Log;
use App\Mail\StatusUpdatedMail;

trait NotifiesStatusChange
{
    public static function bootNotifiesStatusChange()
    {
        static::updated(function ($model) {

            Log::info('[NotifiesStatusChange] updated event fired', [
                'class'      => get_class($model),
                'id'         => $model->id,
                'wasChanged' => $model->wasChanged('status'),
                'changes'    => $model->getChanges(),
            ]);

            if (!$model->wasChanged('status')) {
                return;
            }

            // ── Notification ──────────────────────────────────────────────
            try {
                \App\Models\Notification::create([
                    'user_id'         => $model->created_by,
                    'notifiable_type' => get_class($model),
                    'notifiable_id'   => $model->id,
                    'document_type'   => class_basename($model),
                    'document_number' => $model->getDocumentNumber(),
                    'title'           => 'Request Status Updated',
                    'message'         => "Your request #{$model->getDocumentNumber()} is now {$model->status}.",
                    'type'            => 'status_update',
                ]);
                Log::info('[NotifiesStatusChange] Notification created.');
            } catch (\Throwable $e) {
                Log::error('[NotifiesStatusChange] Notification::create failed: ' . $e->getMessage());
            }

            // ── Email ─────────────────────────────────────────────────────
            try {
                $user = \App\Models\User::find($model->created_by);
                Log::info('[NotifiesStatusChange] User for email', [
                    'created_by' => $model->created_by,
                    'email'      => $user?->email,
                ]);

                if ($user && $user->email) {
                    Mail::to($user->email)->send(new StatusUpdatedMail($model));
                    Log::info('[NotifiesStatusChange] Email sent to ' . $user->email);
                }
            } catch (\Throwable $e) {
                Log::error('[NotifiesStatusChange] Mail failed: ' . $e->getMessage());
            }
        });
    }
}