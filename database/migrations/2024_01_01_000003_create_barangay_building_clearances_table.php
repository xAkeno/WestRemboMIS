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
            $table->string('trans_number')->nullable();
            $table->string('auto_number')->nullable();
            $table->string('bcert_number')->nullable();
            $table->date('issued_date')->nullable();
            $table->string('prefix')->nullable();
            $table->string('surname')->nullable();
            $table->string('first_name')->nullable();
            $table->string('middle_name')->nullable();
            $table->string('ext_name')->nullable();
            $table->string('establishment')->nullable();
            $table->string('house_block_lot_no')->nullable();
            $table->string('street')->nullable();
            $table->string('zone')->nullable();
            $table->string('contact_no')->nullable();
            $table->string('purpose')->nullable();
            $table->text('purpose_details')->nullable();
            $table->string('or_no')->nullable();
            $table->text('remarks')->nullable();
            $table->string('punong_barangay')->nullable();
            $table->string('for_the_punong_barangay')->nullable();
            $table->string('barangay_position')->nullable();
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

