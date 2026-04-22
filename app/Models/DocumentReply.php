<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DocumentReply extends Model
{
    protected $fillable = [
        'document_type',
        'document_id',
        'user_id',
        'message',
        'status',
    ];
}
