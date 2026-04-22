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

        public function barangayClearance()
        {
            return $this->belongsTo(\App\Models\BarangayClearance::class, 'document_number', 'bcert_number');
        }
        public function barangayBuildingClearance()
        {
            return $this->belongsTo(\App\Models\BarangayBuildingClearance::class, 'document_number', 'bcert_number');
        }
        public function barangayCertificate()
        {
            return $this->belongsTo(\App\Models\BarangayCertificate::class, 'document_number', 'bcert_number');
        }
        public function barangayBusinessClearance()
        {
            return $this->belongsTo(\App\Models\BarangayBusinessClearance::class, 'document_number', 'brgy_business_no');
        }
    }
?>