<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BarangayClearance extends Model
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
        'house_block_lot_no',
        'street',
        'zone',
        'dob',
        'pob',
        'contact_no',
        'period_of_residency',
        'registered_voter',
        'house_owner',
        'relationship_to_owner',
        'purpose',
        'purpose_details',
        'ctc_vrr_no',
        'issued_at',
        'issued_on',
        'or_no',
        'bomarke',
    ];

    protected $casts = [
        'issued_date' => 'date',
        'dob' => 'date',
        'issued_on' => 'date',
    ];
}

