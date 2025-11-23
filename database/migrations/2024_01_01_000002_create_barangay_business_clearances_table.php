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
            $table->string('brgyBusinessNo')->nullalble();
            $table->date('issuedDate')->nullable();
            $table->string('prefix')->nullable();
            $table->string('surname')->nullable();
            $table->string('firstname')->nullable();
            $table->string('middlename')->nullable();
            $table->string('ext')->nullable();
            $table->string('businessName')->nullable();
            $table->string('businessType')->nullable();
            $table->text('businessDetails')->nullable();
            $table->decimal('capital', 15, 2)->nullable();
            $table->string('houseBlockLotNo')->nullable();
            $table->string('street')->nullable();
            $table->string('zone')->nullable();
            $table->string('orNo')->nullable();
            $table->string('inspectedBy')->nullable();
            $table->date('dateOfInspection')->nullable();
            $table->text('inspectionRemarks')->nullable();
            $table->text('inspectedRemarks')->nullable();
            $table->date('dateInspected')->nullable();
            $table->text('inspectedNote')->nullable();
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

