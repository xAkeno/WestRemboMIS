<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Barangay Certificates
        Schema::table('barangay_certificates', function (Blueprint $table) {
            $table->string('email')->nullable()->after('status');
        });

        // Barangay Clearances
        Schema::table('barangay_clearances', function (Blueprint $table) {
            $table->string('email')->nullable()->after('status');
        });

        // Business Clearances
        Schema::table('barangay_business_clearances', function (Blueprint $table) {
            $table->string('email')->nullable()->after('status');
        });

        // Building Clearances
        Schema::table('barangay_building_clearances', function (Blueprint $table) {
            $table->string('email')->nullable()->after('status');
        });

        // Residents (optional but useful)
        Schema::table('residents', function (Blueprint $table) {
            $table->string('email')->nullable()->after('id');
        });
    }

    public function down(): void
    {
        Schema::table('barangay_certificates', function (Blueprint $table) {
            $table->dropColumn('email');
        });

        Schema::table('barangay_clearances', function (Blueprint $table) {
            $table->dropColumn('email');
        });

        Schema::table('barangay_business_clearances', function (Blueprint $table) {
            $table->dropColumn('email');
        });

        Schema::table('barangay_building_clearances', function (Blueprint $table) {
            $table->dropColumn('email');
        });

        Schema::table('residents', function (Blueprint $table) {
            $table->dropColumn('email');
        });
    }
};