<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;
class BarangayBuildingClearance extends Model
{
    use HasFactory;
    
    protected $fillable = [
        'bcert_number',
        'issuedDate',
        'prefix',
        'surname',
        'firstname',
        'middlename',
        'extension',
        'establishment',
        'houseBlockLot',
        'street',
        'zone',
        'purpose',
        'purposeDetails',
        'orNo',
        'remarks',
        'punongBarangay',
        'forThePunongBarangay',
        'barangayPosition',
        'status',
        'created_by',
        'updated_by'
    ];



    protected $casts = [
        'issued_date' => 'date',
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

