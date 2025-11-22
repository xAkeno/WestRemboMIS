<?php

namespace App\Services;

use App\Models\ActivityLog;

class ActivityLogService
{
    public function log($ticketId, $action, $oldStatus = null, $newStatus = null, $staffId = null, $remarks = null)
    {
        return ActivityLog::create([
            'ticket_id' => $ticketId,
            'action' => $action,
            'old_status' => $oldStatus,
            'new_status' => $newStatus,
            'staff_id' => $staffId,
            'remarks' => $remarks,
        ]);
    }
}
