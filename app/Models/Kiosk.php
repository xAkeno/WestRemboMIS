<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Kiosk extends Model
{
    use HasFactory;

    protected $fillable = [
        // ─── Service Identification ───────────────────────────────────────────
        'service_type',
        'bcert_number',
        'brgy_business_no',
        'requester_type',

        // ─── Personal Info ────────────────────────────────────────────────────
        'prefix',
        'first_name',
        'middle_name',
        'surname',
        'ext_name',
        'nick_name',

        // ─── Demographics ─────────────────────────────────────────────────────
        'sex',
        'marital_status',
        'name_of_spouse',
        'date_of_birth',
        'place_of_birth',
        'age',
        'blood_type',
        'height_cm',
        'weight_kg',
        'complexion',
        'religion',

        // ─── Address ──────────────────────────────────────────────────────────
        'house_block_lot_no',
        'street',
        'zone',

        // ─── Residency & Voter Info ───────────────────────────────────────────
        'period_of_residency',
        'registered_voter',
        'voter_status',
        'precinct_no',
        'house_owner',
        'relationship_to_owner',
        'resident_status',

        // ─── Contact ──────────────────────────────────────────────────────────
        'contact_no',
        'email',

        // ─── Employment / PWD ─────────────────────────────────────────────────
        'emp_status',
        'occupation',
        'position',
        'pwd',

        // ─── Purpose ─────────────────────────────────────────────────────────
        'purpose',
        'purpose_details',

        // ─── Business Clearance ───────────────────────────────────────────────
        'business_name',
        'business_type',
        'business_details',
        'capital',

        // ─── Building Clearance ───────────────────────────────────────────────
        'establishment',

        // ─── Inspection Fields ────────────────────────────────────────────────
        'inspected_by',
        'date_of_inspection',
        'inspection_remarks',
        'inspected_remarks',
        'date_inspected',
        'inspected_note',

        // ─── CTC / OR / Issuance ─────────────────────────────────────────────
        'ctc_vrr_no',
        'or_no',
        'issued_at',
        'issued_on',
        'issued_date',
        'expires_at',

        // ─── Punong Barangay ──────────────────────────────────────────────────
        'punong_barangay',
        'for_the_punong_barangay',
        'barangay_position',

        // ─── Remarks / Notes / Media ──────────────────────────────────────────
        'remarks',
        'notes',
        'photo',

        // ─── Kiosk Queue ──────────────────────────────────────────────────────
        'priority',
        'authorized_person',

        // ─── Status & Document Release ────────────────────────────────────────
        'status',
        'released_document_path',
        'released_at',

        // ─── Audit ───────────────────────────────────────────────────────────
        'created_by',
        'updated_by',
    ];

    protected $casts = [
        'date_of_birth'      => 'date',
        'issued_date'        => 'date',
        'issued_on'          => 'date',
        'date_of_inspection' => 'date',
        'date_inspected'     => 'date',
        'expires_at'         => 'datetime',
        'released_at'        => 'datetime',
        'capital'            => 'decimal:2',
        'age'                => 'integer',
        'height_cm'          => 'integer',
        'weight_kg'          => 'integer',
    ];

    // ─── Relationships ────────────────────────────────────────────────────────

    public function createdBy()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function updatedBy()
    {
        return $this->belongsTo(User::class, 'updated_by');
    }

    // ─── Scopes ───────────────────────────────────────────────────────────────

    public function scopeByServiceType($query, string $type)
    {
        return $query->where('service_type', $type);
    }

    public function scopePending($query)
    {
        return $query->where('status', 'ENCODED');
    }

    public function scopeByPriority($query, string $priority)
    {
        return $query->where('priority', $priority);
    }

    // ─── Accessors ────────────────────────────────────────────────────────────

    public function getFullNameAttribute(): string
    {
        return trim(implode(' ', array_filter([
            $this->prefix,
            $this->first_name,
            $this->middle_name,
            $this->surname,
            $this->ext_name,
        ])));
    }

    public function getFullAddressAttribute(): string
    {
        return trim(implode(', ', array_filter([
            $this->house_block_lot_no,
            $this->street,
            $this->zone,
        ])));
    }
}