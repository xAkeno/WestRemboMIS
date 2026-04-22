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
        Schema::create('document_replies', function (Blueprint $table) {
            $table->id();

            // 🔥 Dynamic reference (works for ALL document types)
            $table->string('document_type'); // barangay_clearance, business_clearance, etc
            $table->unsignedBigInteger('document_id');

            // Staff who replied
            $table->unsignedBigInteger('user_id')->nullable();

            // Message content
            $table->text('message');

            // Optional: type of reply
            $table->enum('status', ['info', 'warning', 'missing', 'approved'])->default('info');

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('document_replies');
    }
};
