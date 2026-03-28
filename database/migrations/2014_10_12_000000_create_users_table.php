<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();

            // Name details
            $table->string('prefix')->nullable(); // Mr., Ms., etc.
            $table->string('surname');
            $table->string('first_name');
            $table->string('middle_name')->nullable();
            $table->string('extension_name')->nullable(); // Jr., Sr., III
            $table->string('nickname')->nullable();

            // Personal info
            $table->enum('sex', ['Male', 'Female']);
            $table->string('marital_status')->nullable();
            $table->string('name_of_spouse')->nullable();
            $table->string('url_photo')->nullable();

            $table->date('date_of_birth');
            $table->string('place_of_birth')->nullable();
            $table->string('religion')->nullable();

            // Contact info
            $table->string('email')->nullable()->unique();
            $table->string('contact_number')->nullable();

            // Address
            $table->string('house_block_lot_no')->nullable();
            $table->string('street')->nullable();
            $table->string('zone_purok')->nullable();
            $table->string('house_owner')->nullable();
            $table->string('relationship_to_owner')->nullable();

            // Residency
            $table->string('resident_status')->nullable();
            $table->string('period_of_residency')->nullable(); // e.g. 5 years

            // Voter info
            $table->enum('voter_status', ['Registered', 'Not Registered'])->nullable();
            $table->string('precinct_no')->nullable();

            // Employment
            $table->string('employment_status')->nullable();
            $table->string('occupation')->nullable();
            $table->string('position')->nullable();

            // Health / Physical
            $table->boolean('pwd_status')->default(false);
            $table->integer('height_cm')->nullable();
            $table->integer('weight_kg')->nullable();
            $table->string('blood_type')->nullable();
            $table->string('complexion')->nullable();

            // Admin/login info
            $table->string('username')->nullable()->unique();
            $table->string('password')->nullable();
            $table->json('permissions')->nullable();
            $table->string('role')->nullable()->default('USER');
            $table->string('status')->nullable()->default('inactive');

            $table->timestamps();
        });

        // Insert default admin
        DB::table('users')->insert([
            'first_name' => 'Admin',
            'surname'    => 'User',
            'username'   => 'admin',
            'email'      => 'admin@example.com',
            'password'   => Hash::make('admin123'),
            'date_of_birth' => '2000-01-01', // or any valid date
            'permissions'=> json_encode([
                'resident','doc_req','certificate','cashier','reports','settings'
            ]),
            'role'       => 'ADMIN',
            'status'     => 'active',
            'created_at' => now(),
            'updated_at' => now(),
        ]);

    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};
