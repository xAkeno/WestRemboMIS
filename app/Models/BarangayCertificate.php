<?php
    namespace App\Models;

    use Illuminate\Database\Eloquent\Factories\HasFactory;
    use Illuminate\Database\Eloquent\Model;

    class BarangayCertificate extends Model{
        use HasFactory;

        protected $fillable = [
            'trans_number',
            'bcert_number',
            'issued_date',
            'prefix',
            'firstname',
            'middle_name',
            'surname',
            'extension',
            'house_block_lot_no',
            'street',
            'zone',
            'age',
            'date_of_birth',
            'place_of_birth',
            'contact_no',
            'period_of_residency',
            'registered_voter',
            'house_owner',
            'relationship_to_owner',
            'purpose',
            'purpose_details',
            'punong_barangay',
            'for_the_punong_barangay',
        ];
        protected $casts = [
            'issued_date' => 'date',
            'date_of_birth' => 'date',
            'created_at' => 'date',
            'age' => 'integer',
        ];
    }
?>