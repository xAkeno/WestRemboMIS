<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class ActivityLogResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'action' => $this->action,
            'old_status' => $this->old_status,
            'new_status' => $this->new_status,
            'staff_id' => $this->staff_id,
            'remarks' => $this->remarks,
            'created_at' => $this->created_at,
        ];
    }
}
