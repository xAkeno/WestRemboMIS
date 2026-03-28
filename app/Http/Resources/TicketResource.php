<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class TicketResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'ticket_number' => $this->ticket_number,
            'service_type' => $this->service_type,
            'requester_id' => $this->requester_id,
            'status' => $this->status,
            'priority' => $this->priority,
            'submitted_at' => $this->submitted_at,
            'in_progress_at' => $this->in_progress_at,
            'approved_at' => $this->approved_at,
            'rejected_at' => $this->rejected_at,
            'released_at' => $this->released_at,
            'processed_by' => $this->processed_by,
            'serviceable' => $this->whenLoaded('serviceable') ? $this->serviceable : null,
            'activity_logs' => ActivityLogResource::collection($this->whenLoaded('activityLogs')),
            'remarks' => RemarkResource::collection($this->whenLoaded('remarks')),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
