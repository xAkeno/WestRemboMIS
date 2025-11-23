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
        // Change default status for residents table
        Schema::table('residents', function (Blueprint $table) {
            $table->string('status', 50)->nullable()->default('ENCODED')->change();
        });

        // Change default status for barangay_business_clearances table
        Schema::table('barangay_business_clearances', function (Blueprint $table) {
            $table->string('status', 50)->nullable()->default('ENCODED')->change();
        });

        // Change default status for barangay_building_clearances table
        Schema::table('barangay_building_clearances', function (Blueprint $table) {
            $table->string('status', 50)->nullable()->default('ENCODED')->change();
        });

        // Change default status for barangay_clearances table
        Schema::table('barangay_clearances', function (Blueprint $table) {
            $table->string('status', 50)->nullable()->default('ENCODED')->change();
        });

        // Change default status for barangay_certificates table
        Schema::table('barangay_certificates', function (Blueprint $table) {
            $table->string('status', 50)->nullable()->default('ENCODED')->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Revert status defaults back to PENDING
        Schema::table('residents', function (Blueprint $table) {
            $table->string('status', 50)->nullable()->default('PENDING')->change();
        });

        Schema::table('barangay_business_clearances', function (Blueprint $table) {
            $table->string('status', 50)->nullable()->default('PENDING')->change();
        });

        Schema::table('barangay_building_clearances', function (Blueprint $table) {
            $table->string('status', 50)->nullable()->default('PENDING')->change();
        });

        Schema::table('barangay_clearances', function (Blueprint $table) {
            $table->string('status', 50)->nullable()->default('PENDING')->change();
        });

        Schema::table('barangay_certificates', function (Blueprint $table) {
            $table->string('status', 50)->nullable()->default('PENDING')->change();
        });
    }
};
