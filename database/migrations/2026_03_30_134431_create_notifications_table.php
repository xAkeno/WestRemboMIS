<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('notifications', function (Blueprint $table) {
            $table->id();

            $table->foreignId('user_id')->constrained()->cascadeOnDelete();

            // What document this is about
            $table->string('document_type'); // barangay_clearance, etc
            $table->string('document_number'); // BCLEAR-001

            // Notification content
            $table->string('title');
            $table->text('message');

            // Type of notification
            $table->enum('type', [
                'status_update',
                'schedule',
                'reschedule',
                'remark',
                'pickup_ready'
            ]);

            $table->timestamp('read_at')->nullable();

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('notifications');
    }
};
