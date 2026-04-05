<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Barangay Clearance
        Schema::table('barangay_clearances', function (Blueprint $table) {
            $table->timestamp('expires_at')->nullable()->after('issued_date');
        });

        // Business Clearance
        Schema::table('barangay_business_clearances', function (Blueprint $table) {
            $table->timestamp('expires_at')->nullable()->after('issued_date');
        });

        // Building Clearance
        Schema::table('barangay_building_clearances', function (Blueprint $table) {
            $table->timestamp('expires_at')->nullable()->after('issued_date');
        });

        // Barangay Certificate
        Schema::table('barangay_certificates', function (Blueprint $table) {
            $table->timestamp('expires_at')->nullable()->after('issued_date');
        });
    }

    public function down(): void
    {
        Schema::table('barangay_clearances', function (Blueprint $table) {
            $table->dropColumn('expires_at');
        });

        Schema::table('business_clearances', function (Blueprint $table) {
            $table->dropColumn('expires_at');
        });

        Schema::table('building_clearances', function (Blueprint $table) {
            $table->dropColumn('expires_at');
        });

        Schema::table('barangay_certificates', function (Blueprint $table) {
            $table->dropColumn('expires_at');
        });
    }
};