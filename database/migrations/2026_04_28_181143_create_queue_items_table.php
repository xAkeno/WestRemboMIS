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
       Schema::create('queue_items', function (Blueprint $table) {
            $table->id();

            $table->string('document_type'); // barangay_clearance, business_clearance, etc
            $table->unsignedBigInteger('document_id');

            $table->string('reference_number');
            $table->string('status')->default('waiting'); // waiting | serving | done

            $table->boolean('manual_added')->default(false);

            $table->date('queue_date');

            $table->timestamps();

            $table->unique(['document_type', 'document_id', 'queue_date']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('queue_items');
    }
};
