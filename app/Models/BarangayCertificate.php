<?php
    namespace App\Models;

    use Illuminate\Database\Eloquent\Factories\HasFactory;
    use Illuminate\Database\Eloquent\Model;
    use App\Models\User;
    use App\Traits\NotifiesStatusChange;
    class BarangayCertificate extends Model{
        use HasFactory;
        use NotifiesStatusChange;
        protected $fillable = [
            'bcert_number',
            'issued_date',
            'prefix',
            'first_name',
            'middle_name',
            'surname',
            'extension',
            'requester_type',
            'house_block_lot_no',
            'street',
            'zone',
            'age',
            'dob',
            'pob',
            'contact_no',
            'period_of_residency',
            'registered_voter',
            'house_owner',
            'relationship_to_owner',
            'purpose',
            'purpose_details',
            'punong_barangay',
            'for_the_punong_barangay',
            'status',
            'created_by',
            'updated_by',
            'released_document_path',
            'released_at',
            'document_hash',
            'ipfs_cid',
            'email',
            'or_no',
            'downloaded_document_path',
            'downloaded_document_hash',
            'downloaded_ipfs_cid',
            'downloaded_at',
        ];
        protected $casts = [
            'issued_date' => 'date',
            'date_of_birth' => 'date',
            'created_at' => 'date',
            'age' => 'integer',
        ];

        public function toApi()
        {
            return [
                'id' => $this->id,
                'bcert_number' => $this->bcert_number,
                'first_name' => $this->first_name,
                'middle_name' => $this->middle_name,
                'surname' => $this->surname,
                'extension' => $this->extension,
                'pob' => $this->pob,
                'dob' => $this->dob,
                'contact_no' => $this->contact_no,
                'street' => $this->street,
                'zone' => $this->zone,
                'status' => $this->status,
                'created_at' => $this->created_at,
            ];
        }

        public function creator()
        {
            return $this->belongsTo(User::class, 'created_by');
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
?>