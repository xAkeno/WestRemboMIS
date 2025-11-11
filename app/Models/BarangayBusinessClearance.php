<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;
class BarangayBusinessClearance extends Model
{
    use HasFactory;
    protected $fillable = [
        'trans_number',
        'bcert_number',
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
        'contact_no',
        'or_no',
        'remarks',
        'inspected_by',
        'date_of_inspection',
        'inspection_remarks',
        'attachment',
        'punong_barangay',
        'for_the_punong_barangay',
        'barangay_position',
        'created_at',
    ];

    protected $casts = [
        'issued_date' => 'date',
        'date_of_inspection' => 'date',
        'capital' => 'decimal:2',
        'created_at',
    ];
    public function created_by(){
        return $this->belongTo(User::class);
    }
}

