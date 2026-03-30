<?php
    // app/Models/Schedule.php

    namespace App\Models;

    use Illuminate\Database\Eloquent\Model;

    class Schedule extends Model
    {
        protected $fillable = [
            'user_id',
            'document_type',
            'document_number',
            'schedule_date',
            'schedule_time',
        ];
    }
?>