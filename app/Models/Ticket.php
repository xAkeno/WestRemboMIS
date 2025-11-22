<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ticket extends Model
{
    use HasFactory;

    protected $fillable = [
        'ticket_number',
        'service_type',
        'requester_id',
        'status',
        'priority',
        'submitted_at',
        'serviceable_type',
        'serviceable_id',
        'processed_by',
        'in_progress_at',
        'approved_at',
        'rejected_at',
        'released_at',
    ];

    protected $dates = [
        'submitted_at',
        'in_progress_at',
        'approved_at',
        'rejected_at',
        'released_at',
    ];

    public function requester()
    {
        return $this->belongsTo(User::class, 'requester_id');
    }

    public function processor()
    {
        return $this->belongsTo(User::class, 'processed_by');
    }

    public function activityLogs()
    {
        return $this->hasMany(ActivityLog::class);
    }

    public function remarks()
    {
        return $this->hasMany(Remark::class);
    }

    /**
     * Polymorphic relation to the created service record (clearance, certificate, resident)
     */
    public function serviceable()
    {
        return $this->morphTo();
    }
}
