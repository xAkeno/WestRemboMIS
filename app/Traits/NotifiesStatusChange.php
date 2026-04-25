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

            if (!$model->wasChanged('status')) {
                return;
            }

            $status = strtoupper($model->status);

            $user = \App\Models\User::find($model->created_by);

            // ─────────────────────────────
            // 1. NOTIFICATION ONLY
            // ─────────────────────────────
            $notificationOnlyStatuses = ['PAID', 'TO_PAY', 'RELEASED'];

            if (in_array($status, $notificationOnlyStatuses)) {

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

                    Log::info('[Status] Notification sent only (no email)', [
                        'status' => $status,
                    ]);

                } catch (\Throwable $e) {
                    Log::error('[Status] Notification failed: ' . $e->getMessage());
                }

                return;
            }

            // ─────────────────────────────
            // 2. RESCHEDULED → NOTIFICATION + EMAIL
            // ─────────────────────────────
            if ($status === 'RESCHEDULED') {

                try {
                    \App\Models\Notification::create([
                        'user_id'         => $model->created_by,
                        'notifiable_type' => get_class($model),
                        'notifiable_id'   => $model->id,
                        'document_type'   => class_basename($model),
                        'document_number' => $model->getDocumentNumber(),
                        'title'           => 'Request Rescheduled',
                        'message'         => "Your request #{$model->getDocumentNumber()} has been rescheduled.",
                        'type'            => 'rescheduled',
                    ]);

                } catch (\Throwable $e) {
                    Log::error('[Status] Notification failed: ' . $e->getMessage());
                }

                try {
                    if ($user && $user->email) {
                        Mail::to($user->email)->send(new StatusUpdatedMail($model));

                        Log::info('[Status] RESCHEDULED email sent', [
                            'email' => $user->email,
                        ]);
                    }
                } catch (\Throwable $e) {
                    Log::error('[Status] Mail failed: ' . $e->getMessage());
                }

                return;
            }

            // ─────────────────────────────
            // 3. ALL OTHER STATUSES → DO NOTHING
            // ─────────────────────────────
        });
    }
}