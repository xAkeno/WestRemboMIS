<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;
class BarangayBusinessClearance extends Model
{
    use HasFactory;
    protected $fillable = [
        'brgyBusinessNo',
        'issuedDate',
        'prefix',
        'surname',
        'firstname',
        'middlename',
        'ext',
        'businessName',
        'businessType',
        'businessDetails',
        'capital',
        'houseBlockLotNo',
        'street',
        'zone',
        'orNo',
        'inspectedBy',
        'dateOfInspection',
        'inspectionRemarks',
        'inspectedRemarks',
        'dateInspected',
        'inspectedNote',
        'status',
        'created_by',
        'updated_by'
    ];

    protected $casts = [
        'issuedDate' => 'date',
        'dateOfInspection' => 'date',
        'capital' => 'decimal:2',
    ];

    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function updater()
    {
        return $this->belongsTo(User::class, 'updated_by');
    }
}

