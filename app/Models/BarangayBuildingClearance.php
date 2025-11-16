<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;
class BarangayBuildingClearance extends Model
{
    use HasFactory;

    protected $fillable = [
        'trans_number',
        'auto_number',
        'bcert_number',
        'issued_date',
        'prefix',
        'surname',
        'first_name',
        'middle_name',
        'ext_name',
        'establishment',
        'house_block_lot_no',
        'street',
        'zone',
        'contact_no',
        'purpose',
        'purpose_details',
        'or_no',
        'remarks',
        'punong_barangay',
        'for_the_punong_barangay',
        'barangay_position'
    ];

    protected $casts = [
        'issued_date' => 'date',
        'created_at' => 'date',
    ];
    // public function created_by(){
    //     return $this->belongTo(User::class);
    // }
}

