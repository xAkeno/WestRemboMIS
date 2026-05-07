<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;
use App\Traits\NotifiesStatusChange;
class BarangayClearance extends Model
{
    use HasFactory;
    use NotifiesStatusChange;
    protected $fillable = [
        'bcert_number',
        'issued_date',
        'prefix',
        'surname',
        'first_name',
        'requester_type',
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
        'remarks',
        'status',
        'created_by',
        'updated_by',
        'released_document_path',
        'released_at',
        'document_hash',
        'ipfs_cid',
        'email',
        'downloaded_document_path',
        'downloaded_document_hash',
        'downloaded_ipfs_cid',
        'downloaded_at',
    ];

    protected $casts = [
        'issued_date' => 'date',
        'dob' => 'date',
        'issued_on' => 'date',
    ];

    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function toApi()
    {
        return [
            'id' => $this->id,
            'bcert_number' => $this->bcert_number,
            'first_name' => $this->first_name,
            'surname' => $this->surname,
            'pob' => $this->pob,
            'dob' => $this->dob,
            'contact_no' => $this->contact_no,
            'street' => $this->street,
            'zone' => $this->zone,
            'status' => $this->status,
        ];
    }

    public function schedule()
    {
        return $this->hasOne(\App\Models\Schedule::class, 'document_number', 'bcert_number');
    }

    public function getDocumentNumber()
    {
        return $this->bcert_number;
    }

    public function updater()
    {
        return $this->belongsTo(User::class, 'updated_by');
    }
    public function user()
    {
        return $this->belongsTo(User::class, 'created_by');
    }
}

