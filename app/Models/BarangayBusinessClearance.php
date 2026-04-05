<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;
use App\Traits\NotifiesStatusChange;
class BarangayBusinessClearance extends Model
{
    use HasFactory;
    use NotifiesStatusChange;
    protected $fillable = [
        'brgy_business_no',
        'requester_type',
        'issued_date',
        'prefix',
        'surname',
        'first_name',
        'middle_name',
        'ext_name',
        'business_name',
        'business_type',
        'business_details',
        'capital',
        'house_block_lot_no',
        'street',
        'zone',
        'or_no',
        'inspected_by',
        'date_of_inspection',
        'inspection_remarks',
        'inspected_remarks',
        'date_inspected',
        'inspected_note',
        'status',
        'created_by',
        'updated_by',
        'released_document_path',
        'released_at',
    ];

    protected $casts = [
        'issued_date' => 'date',
        'date_of_inspection' => 'date',
        'capital' => 'decimal:2',
    ];

    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function schedule()
    {
        return $this->hasOne(\App\Models\Schedule::class, 'document_number', 'brgy_business_no');
    }

    public function updater()
    {
        return $this->belongsTo(User::class, 'updated_by');
    }
    public function user()
    {
        return $this->belongsTo(User::class, 'created_by');
    }
    public function getDocumentNumber()
    {
        return $this->brgy_business_no;
    }
}

