<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ScheduleSlot extends Model
{
    protected $fillable = [
        'document_type',
        'schedule_time',
        'max_slots',
    ];
}