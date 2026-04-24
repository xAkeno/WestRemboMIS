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
            $table->timestamp('last_activity_at')->nullable()->after('status');
            $table->timestamp('warning_sent_at')->nullable()->after('last_activity_at');
        });

        // Barangay Clearances
        Schema::table('barangay_clearances', function (Blueprint $table) {
            $table->timestamp('last_activity_at')->nullable()->after('status');
            $table->timestamp('warning_sent_at')->nullable()->after('last_activity_at');
        });

        // Business Clearances
        Schema::table('barangay_business_clearances', function (Blueprint $table) {
            $table->timestamp('last_activity_at')->nullable()->after('status');
            $table->timestamp('warning_sent_at')->nullable()->after('last_activity_at');
        });

        // Building Clearances
        Schema::table('barangay_building_clearances', function (Blueprint $table) {
            $table->timestamp('last_activity_at')->nullable()->after('status');
            $table->timestamp('warning_sent_at')->nullable()->after('last_activity_at');
        });
    }

    public function down(): void
    {
        Schema::table('barangay_certificates', function (Blueprint $table) {
            $table->dropColumn(['last_activity_at', 'warning_sent_at']);
        });

        Schema::table('barangay_clearances', function (Blueprint $table) {
            $table->dropColumn(['last_activity_at', 'warning_sent_at']);
        });

        Schema::table('barangay_business_clearances', function (Blueprint $table) {
            $table->dropColumn(['last_activity_at', 'warning_sent_at']);
        });

        Schema::table('barangay_building_clearances', function (Blueprint $table) {
            $table->dropColumn(['last_activity_at', 'warning_sent_at']);
        });
    }
};