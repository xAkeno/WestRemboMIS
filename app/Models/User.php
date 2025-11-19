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
        'name',
        'email',
        'username',
        'password',
        'permissions'
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

