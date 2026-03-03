<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Official extends Model
{
    protected $fillable = [
        'profile_image',
        'full_name',
        'position',
        'committee_role',
        'term',
        'display_order',
        'visible', 
    ];
}