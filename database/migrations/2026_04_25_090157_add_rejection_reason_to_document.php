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
            $table->text('rejection_reason')->nullable()->after('status');
        });

        // Barangay Clearances
        Schema::table('barangay_clearances', function (Blueprint $table) {
            $table->text('rejection_reason')->nullable()->after('status');
        });

        // Business Clearances
        Schema::table('barangay_business_clearances', function (Blueprint $table) {
            $table->text('rejection_reason')->nullable()->after('status');
        });

        // Building Clearances
        Schema::table('barangay_building_clearances', function (Blueprint $table) {
            $table->text('rejection_reason')->nullable()->after('status');
        });
    }

    public function down(): void
    {
        Schema::table('barangay_certificates', function (Blueprint $table) {
            $table->dropColumn('rejection_reason');
        });

        Schema::table('barangay_clearances', function (Blueprint $table) {
            $table->dropColumn('rejection_reason');
        });

        Schema::table('barangay_business_clearances', function (Blueprint $table) {
            $table->dropColumn('rejection_reason');
        });

        Schema::table('barangay_building_clearances', function (Blueprint $table) {
            $table->dropColumn('rejection_reason');
        });
    }
};