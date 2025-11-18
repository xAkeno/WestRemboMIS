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
        'issued_date',
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
        'barangayPosition'
    ];

    protected $casts = [
        'issued_date' => 'date',
    ];
    // public function created_by(){
    //     return $this->belongTo(User::class);
    // }
}

