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
        Schema::create('barangay_business_clearances', function (Blueprint $table) {
            $table->id();
            $table->string('trans_number')->nullable();
            $table->string('bcert_number')->nullable();
            $table->date('issued_date')->nullable();
            $table->string('prefix')->nullable();
            $table->string('surname')->nullable();
            $table->string('first_name')->nullable();
            $table->string('middle_name')->nullable();
            $table->string('ext_name')->nullable();
            $table->string('business_name')->nullable();
            $table->string('business_type')->nullable();
            $table->text('business_details')->nullable();
            $table->decimal('capital', 15, 2)->nullable();
            $table->string('house_block_lot_no')->nullable();
            $table->string('street')->nullable();
            $table->string('zone')->nullable();
            $table->string('contact_no')->nullable();
            $table->string('or_no')->nullable();
            $table->text('remarks')->nullable();
            $table->string('inspected_by')->nullable();
            $table->date('date_of_inspection')->nullable();
            $table->text('inspection_remarks')->nullable();
            $table->string('punong_barangay')->nullable();
            $table->string('for_the_punong_barangay')->nullable();
            $table->string('barangay_position')->nullable();
            // $table->foreignId('created_by')->nullable()->constrained('users')->onDelete('cascade');

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('barangay_business_clearances');
    }
};

