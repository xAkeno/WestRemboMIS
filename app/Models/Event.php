<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Event extends Model
{
    protected $fillable = [
        'title',
        'description',
        'location',
        'date',
        'start_time',
        'end_time',
        'image',
        'published',
        'color',
        'important',
    ];
}
