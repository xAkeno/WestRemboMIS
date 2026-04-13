<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Kiosk extends Model
{
    use HasFactory;

    protected $fillable = [
        'service_type',
        'first_name',
        'surname',
        'middle_name',
        'authorized_person',
        'address',
        'date_of_birth',
        'place_of_birth',
        'period_of_residency',
        'registered_voter',
        'house_owner',
        'relation_to_house_owner',
        'contact_number',
        'purpose',
        'priority',
        'operator_id',
    ];

    protected $dates = [
        'date_of_birth',
    ];

    public function operator()
    {
        return $this->belongsTo(User::class, 'operator_id');
    }
}
