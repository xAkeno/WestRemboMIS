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
            $table->string('requester_type')->nullable();
            $table->date('issued_date')->nullable();          // was issuedDate
            $table->string('prefix')->nullable();
            $table->string('surname')->nullable();
            $table->string('first_name')->nullable();        // was firstname
            $table->string('middle_name')->nullable();       // was middlename
            $table->string('ext_name')->nullable();          // was extension
            $table->string('establishment')->nullable();
            $table->string('house_block_lot_no')->nullable();   // was houseBlockLot
            $table->string('street')->nullable();
            $table->string('zone')->nullable();
            $table->string('purpose')->nullable();
            $table->text('purpose_details')->nullable();     // was purposeDetails
            $table->string('or_no')->nullable();             // was orNo
            $table->text('remarks')->nullable();
            $table->string('punong_barangay')->nullable();   // was punongBarangay
            $table->string('for_the_punong_barangay')->nullable(); // was forThePunongBarangay
            $table->string('barangay_position')->nullable(); // was barangayPosition
            // $table->foreignId('created_by')->nullable()->constrained('users')->onDelete('cascade');
            $table->string('status', 50)->nullable()->default('ENCODED');
            
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