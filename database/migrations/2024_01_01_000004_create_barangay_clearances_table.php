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
        Schema::create('barangay_clearances', function (Blueprint $table) {
            $table->id();
            $table->string('trans_number')->nullable();
            $table->string('bcert_number')->nullable();
            $table->date('issued_date')->nullable();
            $table->string('prefix')->nullable();
            $table->string('surname')->nullable();
            $table->string('first_name')->nullable();
            $table->string('middle_name')->nullable();
            $table->string('ext_name')->nullable();
            $table->string('house_block_lot_no')->nullable();
            $table->string('street')->nullable();
            $table->string('zone')->nullable();
            $table->date('dob')->nullable();
            $table->string('pob')->nullable();
            $table->string('contact_no')->nullable();
            $table->string('period_of_residency')->nullable();
            $table->string('registered_voter')->nullable();
            $table->string('house_owner')->nullable();
            $table->string('relationship_to_owner')->nullable();
            $table->string('purpose')->nullable();
            $table->text('purpose_details')->nullable();
            $table->string('ctc_vrr_no')->nullable();
            $table->string('issued_at')->nullable();
            $table->date('issued_on')->nullable();
            $table->string('or_no')->nullable();
            $table->string('bomarke')->nullable();
            $table->foreignId('created_by')->constrained("users")->onDelete("cascade");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('barangay_clearances');
    }
};

