<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ContactCms extends Model
{
    use HasFactory;

    protected $fillable = [
        'address',
        'email',
        'telephone',
        'facebook',
        'office_days',
        'office_hours'
    ];
}