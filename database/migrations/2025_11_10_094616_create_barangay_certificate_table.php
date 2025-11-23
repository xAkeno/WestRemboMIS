<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *             'trans_number',
     * 
     */
    public function up(): void
    {
        Schema::create('barangay_certificates', function (Blueprint $table) {
            $table->id();
            $table->string('bcert_number', 50);
            $table->date('issued_date');
            $table->string('prefix', 10)->nullable();
            $table->string('firstname', 100);
            $table->string('middle_name', 100)->nullable();
            $table->string('surname', 100);
            $table->string('extension', 10)->nullable();
            $table->string('house_block_lot_no', 50)->nullable();
            $table->string('street', 100)->nullable();
            $table->string('zone', 50)->nullable();
            $table->integer('age')->nullable();
            $table->date('date_of_birth')->nullable();
            $table->string('place_of_birth', 150)->nullable();
            $table->string('contact_no', 20)->nullable();
            $table->string('period_of_residency', 50)->nullable();
            $table->string('registered_voter', 20)->nullable();
            $table->string('house_owner', 100)->nullable();
            $table->string('relationship_to_owner', 50)->nullable();
            $table->string('purpose', 100);
            $table->text('purpose_details')->nullable();
            $table->string('punong_barangay', 100)->nullable();
            $table->string('for_the_punong_barangay', 100)->nullable();
            $table->string('status', 50)->nullable()->default('ENCODED');

            // $table->foreignId('created_by')->nullable()->constrained('users')->onDelete('cascade');

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('barangay_certificate');
    }
};
