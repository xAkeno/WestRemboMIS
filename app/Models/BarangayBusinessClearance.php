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
        'inspectedNote'
    ];

    protected $casts = [
        'issuedDate' => 'date',
        'dateOfInspection' => 'date',
        'capital' => 'decimal:2',
    ];

    // public function created_by(){
    //     return $this->belongTo(User::class);
    // }
}

