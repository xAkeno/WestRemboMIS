<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BackupSetting extends Model
{
    protected $fillable = [
        'frequency',   // hourly, daily, weekly
        'time',        // "02:00" (24h format) — null when hourly
        'enabled',
        'day_of_week', // 0 = Sunday ... 6 = Saturday — null unless weekly
    ];

    protected $casts = [
        'enabled'     => 'boolean',
        'day_of_week' => 'integer',
    ];
}