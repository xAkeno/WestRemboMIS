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

        // 🔥 REQUIRED FOR QUEUE SYSTEM
        'type',
        'position',
        'queue_date',
        'scheduled_time',
        'called_at',
        'missed_attempts',
        'schedule_id',
        'requeued_at',
        'arrived_at',

        'serviceable_type',
        'serviceable_id',
        'processed_by',
        'in_progress_at',
        'approved_at',
        'rejected_at',
        'released_at',
    ];

    protected $casts = [
        'submitted_at'   => 'datetime',
        'queue_date'     => 'date',
        'scheduled_time' => 'datetime:H:i',
        'called_at'      => 'datetime',
        'requeued_at'    => 'datetime',
        'arrived_at'     => 'datetime',
    ];

    public function requester()
    {
        return $this->belongsTo(User::class, 'requester_id');
    }

    protected static function boot()
    {
        parent::boot();

        static::saving(function ($ticket) {
            if (!empty($ticket->service_type)) {
                $ticket->service_type = ucwords(
                    str_replace('_', ' ', strtolower($ticket->service_type))
                );
            }
        });
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
