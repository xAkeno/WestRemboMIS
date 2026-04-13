<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class TicketResource extends JsonResource
{
    public function toArray($request)
    {
        return array_merge(
            // ✅ THIS RETURNS ALL DATABASE COLUMNS
            $this->resource->toArray(),

            [
                // ✅ SAFE RELATIONS (only if loaded)
                'serviceable' => $this->whenLoaded('serviceable'),

                'remarks' => RemarkResource::collection(
                    $this->whenLoaded('remarks')
                ),
            ]
        );
    }
}