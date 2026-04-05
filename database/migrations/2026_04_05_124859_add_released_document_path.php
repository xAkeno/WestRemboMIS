<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Add released_document_path to all clearance/certificate tables.
     * Run: php artisan migrate
     */
    public function up(): void
    {
        $tables = [
            'barangay_certificates',
            'barangay_clearances',
            'barangay_building_clearances',
            'barangay_business_clearances',
        ];

        foreach ($tables as $table) {
            Schema::table($table, function (Blueprint $table) {
                $table->string('released_document_path')->nullable()->after('status');
                $table->timestamp('released_at')->nullable()->after('released_document_path');
            });
        }
    }

    public function down(): void
    {
        $tables = [
            'barangay_certificates',
            'barangay_clearances',
            'building_clearances',
            'business_clearances',
        ];

        foreach ($tables as $table) {
            Schema::table($table, function (Blueprint $table) {
                $table->dropColumn(['released_document_path', 'released_at']);
            });
        }
    }
};