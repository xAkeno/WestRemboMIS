<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;
use App\Traits\NotifiesStatusChange;
class BarangayBuildingClearance extends Model
{
    use HasFactory;
    use NotifiesStatusChange;
    protected $fillable = [
        'bcert_number',
        'requester_type',
        'issued_date',
        'prefix',
        'surname',
        'first_name',
        'middle_name',
        'ext_name',
        'requester_type',
        'establishment',
        'house_block_lot_no',
        'street',
        'zone',
        'purpose',
        'purpose_details',
        'or_no',
        'remarks',
        'punong_barangay',
        'for_the_punong_barangay',
        'barangay_position',
        'status',
        'created_by',
        'updated_by',
        'released_document_path',
        'released_at',
    ];



    protected $casts = [
        'issued_date' => 'date',
    ];

    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function schedule()
    {
        return $this->hasOne(\App\Models\Schedule::class, 'document_number', 'bcert_number');
    }

    public function getDocumentNumber()
    {
        return $this->bcert_number;
    }

    public function updater()
    {
        return $this->belongsTo(User::class, 'updated_by');
    }
    public function user()
    {
        return $this->belongsTo(User::class, 'created_by');
    }
}

