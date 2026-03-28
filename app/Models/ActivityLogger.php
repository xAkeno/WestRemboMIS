<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ActivityLogger extends Model
{
    protected $fillable = [
        'user_id',
        'user_name',
        'user_email',
        'action',
        'type',
        'description',
        'ip_address',
    ];
}
