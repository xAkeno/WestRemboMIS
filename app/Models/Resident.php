<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;

class Resident extends Model
{
    use HasFactory;


    protected $fillable = [
        'resident_id',
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
        'status',
        'created_by',
        'updated_by',
        'user_id'
    ];

    protected $casts = [
        'record_create_date' => 'datetime',
        'date_of_birth' => 'date'
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

   public function schedules()
    {
        return $this->hasManyThrough(
            \App\Models\Schedule::class,
            \App\Models\User::class,
            'id',       // users.id
            'user_id',  // schedules.user_id    
            'user_id',  // residents.user_id
            'id'        // users.id
        );
    }
    public function updater()
    {
        return $this->belongsTo(User::class, 'updated_by');
    }
}

