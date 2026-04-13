<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Adds the columns needed for scheduled-ticket queue support:
     *
     *  schedule_id     — FK to schedules.id (null for walk-in/kiosk tickets)
     *  scheduled_time  — copy of the appointment time (for queue ordering without a JOIN)
     *  requeued_at     — timestamp set when staff re-admits a 'late' ticket
     *
     * Also ensures missed_attempts has a default of 0.
     */
    public function up(): void
    {
        Schema::table('tickets', function (Blueprint $table) {
            // Link to the schedule (nullable — walk-ins have no schedule)
            $table->foreignId('schedule_id')
                  ->nullable()
                  ->after('id')
                  ->constrained('schedules')
                  ->nullOnDelete();

            // Appointment time copied here for efficient ordering
            $table->time('scheduled_time')->nullable()->after('schedule_id');

            // Timestamp for when a late ticket was re-admitted by staff
            $table->timestamp('requeued_at')->nullable()->after('called_at');

            // Make sure missed_attempts defaults to 0 if not already set
            // (safe to run even if column exists — change() just alters it)
            $table->unsignedTinyInteger('missed_attempts')->default(0)->change();
        });
    }

    public function down(): void
    {
        Schema::table('tickets', function (Blueprint $table) {
            $table->dropForeign(['schedule_id']);
            $table->dropColumn(['schedule_id', 'scheduled_time', 'requeued_at']);
        });
    }
};
