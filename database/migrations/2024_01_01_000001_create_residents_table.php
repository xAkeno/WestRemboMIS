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
        Schema::create('residents', function (Blueprint $table) {
            $table->id();
            $table->string('resident_id')->unique();
            $table->string('prefix')->nullable();
            $table->string('surname')->required();
            $table->string('first_name')->required();
            $table->string('middle_name')->nullable();
            $table->string('ext_name')->nullable();
            $table->string('nick_name')->nullable();
            $table->string('sex')->nullable();
            $table->string('marital_status')->nullable();
            $table->string('name_of_spouse')->nullable();
            $table->string('house_block_lot_no')->nullable();
            $table->string('street')->nullable();
            $table->string('zone')->nullable();
            $table->string('resident_status')->nullable();
            $table->date('date_of_birth')->nullable();
            $table->string('place_of_birth')->nullable();
            $table->integer('height_cm')->nullable();
            $table->integer('weight_kg')->nullable();
            $table->string('blood_type')->nullable();
            $table->string('complexion')->nullable();
            $table->string('religion')->nullable();
            $table->string('voter_status')->nullable();
            $table->string('precinct_no')->nullable();
            $table->string('emp_status')->nullable();
            $table->string('occupation')->nullable();
            $table->string('position')->nullable();
            $table->string('pwd')->nullable();
            $table->string('period_of_residency')->nullable();
            $table->string('house_owner')->nullable();
            $table->string('relationship_to_owner')->nullable();
            $table->string('phone_number')->nullable();
            $table->string('email_address')->nullable();
            $table->text('notes')->nullable();
            $table->string('photo')->nullable();
            $table->timestamps();
        });
    }

    protected $casts = [
        'date_of_birth' => 'date'
    ];


    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('residents');
    }
};

