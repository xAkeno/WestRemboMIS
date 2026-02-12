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
            if (Schema::hasColumn('residents', 'status')) {
                $table->string('status', 50)->nullable()->default('ENCODED')->change();
            } else {
                $table->string('status', 50)->nullable()->default('ENCODED');
            }
        });

        // Change default status for barangay_business_clearances table
        Schema::table('barangay_business_clearances', function (Blueprint $table) {
            if (Schema::hasColumn('barangay_business_clearances', 'status')) {
                $table->string('status', 50)->nullable()->default('ENCODED')->change();
            } else {
                $table->string('status', 50)->nullable()->default('ENCODED');
            }
        });

        // Change default status for barangay_building_clearances table
        Schema::table('barangay_building_clearances', function (Blueprint $table) {
            if (Schema::hasColumn('barangay_building_clearances', 'status')) {
                $table->string('status', 50)->nullable()->default('ENCODED')->change();
            } else {
                $table->string('status', 50)->nullable()->default('ENCODED');
            }
        });

        // Change default status for barangay_clearances table
        Schema::table('barangay_clearances', function (Blueprint $table) {
            if (Schema::hasColumn('barangay_clearances', 'status')) {
                $table->string('status', 50)->nullable()->default('ENCODED')->change();
            } else {
                $table->string('status', 50)->nullable()->default('ENCODED');
            }
        });

        // Change default status for barangay_certificates table
        Schema::table('barangay_certificates', function (Blueprint $table) {
            if (Schema::hasColumn('barangay_certificates', 'status')) {
                $table->string('status', 50)->nullable()->default('ENCODED')->change();
            } else {
                $table->string('status', 50)->nullable()->default('ENCODED');
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('residents', function (Blueprint $table) {
            if (Schema::hasColumn('residents', 'status')) {
                $table->string('status', 50)->nullable()->default('PENDING')->change();
            }
        });

        Schema::table('barangay_business_clearances', function (Blueprint $table) {
            if (Schema::hasColumn('barangay_business_clearances', 'status')) {
                $table->string('status', 50)->nullable()->default('PENDING')->change();
            }
        });

        Schema::table('barangay_building_clearances', function (Blueprint $table) {
            if (Schema::hasColumn('barangay_building_clearances', 'status')) {
                $table->string('status', 50)->nullable()->default('PENDING')->change();
            }
        });

        Schema::table('barangay_clearances', function (Blueprint $table) {
            if (Schema::hasColumn('barangay_clearances', 'status')) {
                $table->string('status', 50)->nullable()->default('PENDING')->change();
            }
        });

        Schema::table('barangay_certificates', function (Blueprint $table) {
            if (Schema::hasColumn('barangay_certificates', 'status')) {
                $table->string('status', 50)->nullable()->default('PENDING')->change();
            }
        });
    }
};