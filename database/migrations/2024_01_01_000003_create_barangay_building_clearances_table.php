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
        Schema::create('barangay_building_clearances', function (Blueprint $table) {
            $table->id();
            $table->string('bcert_number')->nullable();
            $table->date('issuedDate')->nullable();
            $table->string('prefix')->nullable();
            $table->string('surname')->nullable();
            $table->string('firstname')->nullable();
            $table->string('middlename')->nullable();
            $table->string('extension')->nullable();
            $table->string('establishment')->nullable();
            $table->string('houseBlockLot')->nullable();
            $table->string('street')->nullable();
            $table->string('zone')->nullable();
            $table->string('purpose')->nullable();
            $table->text('purposeDetails')->nullable();
            $table->string('orNo')->nullable();
            $table->text('remarks')->nullable();
            $table->string('punongBarangay')->nullable();
            $table->string('forThePunongBarangay')->nullable();
            $table->string('barangayPosition')->nullable();
            // $table->foreignId('created_by')->nullable()->constrained('users')->onDelete('cascade');

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('barangay_building_clearances');
    }
};

