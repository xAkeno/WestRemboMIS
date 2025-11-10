<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Resident extends Model
{
    use HasFactory;

    protected $fillable = [
        'resident_id',
        'record_create_date',
        'prefix',
        'surname',
        'first_name',
        'middle_name',
        'ext_name',
        'nick_name',
        'sex',
        'marital_status',
        'name_of_spouse',
        'house_block_lot_no',
        'street',
        'zone',
        'resident_status',
        'date_of_birth',
        'place_of_birth',
        'height_cm',
        'weight_kg',
        'blood_type',
        'complexion',
        'religion',
        'voter_status',
        'precinct_no',
        'emp_status',
        'occupation',
        'position',
        'pwd',
        'period_of_residency',
        'house_owner',
        'relationship_to_owner',
        'phone_number',
        'email_address',
        'notes',
        'photo',
        'created_at',
    ];

    protected $casts = [
        'record_create_date' => 'datetime',
        'date_of_birth' => 'date',
        'created_at' => 'date'
    ];
}

