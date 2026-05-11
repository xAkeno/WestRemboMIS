<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ReprintRequest extends Model
{
    protected $fillable = [
        'user_id',
        'document_type',
        'document_number',
        'reason',
        'status',
    ];
}
