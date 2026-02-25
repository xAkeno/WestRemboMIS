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
            $table->string('brgy_business_no')->nullable();       // was brgyBusinessNo
            $table->string('requester_type')->nullable();
            $table->date('issued_date')->nullable();             // was issuedDate
            $table->string('prefix')->nullable();
            $table->string('surname')->nullable();
            $table->string('first_name')->nullable();           // was firstname
            $table->string('middle_name')->nullable();          // was middlename
            $table->string('ext_name')->nullable();             // was ext
            $table->string('business_name')->nullable();        // was businessName
            $table->string('business_type')->nullable();        // was businessType
            $table->text('business_details')->nullable();       // was businessDetails
            $table->decimal('capital', 15, 2)->nullable();
            $table->string('house_block_lot_no')->nullable();   // was houseBlockLotNo
            $table->string('street')->nullable();
            $table->string('zone')->nullable();
            $table->string('or_no')->nullable();               // was orNo
            $table->string('inspected_by')->nullable();        // was inspectedBy
            $table->date('date_of_inspection')->nullable();    // was dateOfInspection
            $table->text('inspection_remarks')->nullable();   // was inspectionRemarks
            $table->text('inspected_remarks')->nullable();    // was inspectedRemarks
            $table->date('date_inspected')->nullable();       // was dateInspected
            $table->text('inspected_note')->nullable();       // was inspectedNote
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
        Schema::dropIfExists('barangay_business_clearances');
    }
};