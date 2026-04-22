<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use App\Models\BarangayBuildingClearance;
use App\Models\BarangayBusinessClearance;
use App\Models\BarangayCertificate;
use App\Models\BarangayClearance;
use App\Models\Resident;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        // Name details
        'prefix',
        'first_name',
        'middle_name',
        'surname',
        'extension_name',
        'nickname',

        // Personal info
        'sex',
        'marital_status',
        'name_of_spouse',
        'date_of_birth',
        'place_of_birth',
        'religion',

        // Contact info
        'email',
        'contact_number',

        // Address
        'house_block_lot_no',
        'street',
        'zone_purok',
        'house_owner',
        'relationship_to_owner',

        // Residency / voter
        'resident_status',
        'period_of_residency',
        'voter_status',
        'precinct_no',

        // Employment
        'employment_status',
        'occupation',
        'position',

        // Health
        'pwd_status',
        'height_cm',
        'weight_kg',
        'blood_type',
        'complexion',

        // Auth / system
        'username',
        'password',
        'permissions',
        'role',
        'status',
        'id_url',
        'id_url_back',
        'is_approved',
        'email_verification_code',
        'email_verification_expires_at',
        'password_reset_code',
        'password_reset_expires_at',
        'email_verified_at',
    ];


    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }
    public function created_by_building(){
        return $this->hasMany(BarangayBuildingClearance::class);
    }
    public function created_by_business(){
        return $this->hasMany(BarangayBusinessClearance::class);
    }
    public function created_by_certificate(){
        return $this->hasMany(BarangayCertificate::class);
    }
    public function created_by_clearance(){
        return $this->hasMany(BarangayClearance::class);
    }
    public function created_by_resident(){
        return $this->hasMany(Resident::class);
    }
}

