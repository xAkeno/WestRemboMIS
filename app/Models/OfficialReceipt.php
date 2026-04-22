<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OfficialReceipt extends Model
{
    protected $fillable = [
        'or_number',
        'type',
        'reference_id',
        'amount',
        'year',
        'tin_no',  // ← add this
    ];
}

?>