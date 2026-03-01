<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();

            // Name details
            $table->string('prefix')->nullable();
            $table->string('surname');
            $table->string('first_name');
            $table->string('middle_name')->nullable();
            $table->string('extension_name')->nullable();
            $table->string('nickname')->nullable();

            // Personal info
            // ✅ FIXED HERE (added 'Other')
            $table->enum('sex', ['Male', 'Female', 'Other']);
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
            $table->string('period_of_residency')->nullable();

            // Voter info
            $table->enum('voter_status', ['Registered', 'Not Registered'])->nullable();
            $table->string('precinct_no')->nullable();

            // Employment
            $table->string('employment_status')->nullable();
            $table->string('occupation')->nullable();
            $table->string('position')->nullable();

            // Health
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

            $table->string('email_verification_code')->nullable();
            $table->timestamp('email_verification_expires_at')->nullable();

            $table->string('password_reset_code')->nullable();
            $table->timestamp('password_reset_expires_at')->nullable();

            $table->timestamp('email_verified_at')->nullable();

            $table->string('id_url')->nullable();

            $table->timestamps();
        });

        // ✅ Default admin
        DB::table('users')->insert([
            'prefix' => 'Mr.',
            'first_name' => 'Admin',
            'middle_name' => null,
            'surname' => 'User',
            'extension_name' => null,
            'nickname' => 'Admin',
            'sex' => 'Other', // Now valid
            'marital_status' => null,
            'name_of_spouse' => null,
            'date_of_birth' => '2000-01-01',
            'place_of_birth' => 'Philippines',
            'email' => 'admin@example.com',
            'contact_number' => null,
            'house_block_lot_no' => null,
            'street' => null,
            'zone_purok' => null,
            'resident_status' => 'Resident',
            'period_of_residency' => '10 years',
            'voter_status' => 'Registered',
            'username' => 'admin',
            'password' => Hash::make('admin123'),
            'permissions' => json_encode([
                'resident','doc_req','certificate','cashier','reports','settings'
            ]),
            'role' => 'ADMIN',
            'status' => 'active',
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        // ✅ Default staff
        DB::table('users')->insert([
            'prefix'     => 'Mr.',
            'first_name' => 'Clark',
            'surname'    => 'Raguhos',
            'middle_name'=> null,
            'extension_name' => null,
            'nickname'   => 'Clark',
            'sex'        => 'Male',
            'marital_status' => null,
            'name_of_spouse' => null,
            'date_of_birth' => '2000-06-18',
            'place_of_birth'=> 'Philippines',
            'email'      => 'clarkkentraguhos@gmail.com',
            'contact_number' => '09123456789',
            'house_block_lot_no' => null,
            'street'     => null,
            'zone_purok' => null,
            'resident_status' => 'Resident',
            'period_of_residency' => '5 years',
            'voter_status' => 'Registered',
            'username'   => 'clarkuser',
            'password'   => Hash::make('password123'),
            'permissions'=> json_encode([
                'doc_req',
                'certificate'
            ]),
            'role'       => 'STAFF',
            'status'     => 'active',
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }

    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};