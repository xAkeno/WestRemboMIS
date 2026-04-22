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
            $table->string('document_hash')->nullable()->after('status');
            $table->string('ipfs_cid')->nullable()->after('document_hash');
        });

        // Barangay Clearances
        Schema::table('barangay_clearances', function (Blueprint $table) {
            $table->string('document_hash')->nullable()->after('status');
            $table->string('ipfs_cid')->nullable()->after('document_hash');
        });

        // Business Clearances
        Schema::table('barangay_business_clearances', function (Blueprint $table) {
            $table->string('document_hash')->nullable()->after('status');
            $table->string('ipfs_cid')->nullable()->after('document_hash');
        });

        // Building Clearances
        Schema::table('barangay_building_clearances', function (Blueprint $table) {
            $table->string('document_hash')->nullable()->after('status');
            $table->string('ipfs_cid')->nullable()->after('document_hash');
        });

        // Residents (if needed for verification)
        Schema::table('residents', function (Blueprint $table) {
            $table->string('document_hash')->nullable()->after('id');
            $table->string('ipfs_cid')->nullable()->after('document_hash');
        });
    }

    public function down(): void
    {
        Schema::table('barangay_certificates', function (Blueprint $table) {
            $table->dropColumn(['document_hash', 'ipfs_cid']);
        });

        Schema::table('barangay_clearances', function (Blueprint $table) {
            $table->dropColumn(['document_hash', 'ipfs_cid']);
        });

        Schema::table('barangay_business_clearances', function (Blueprint $table) {
            $table->dropColumn(['document_hash', 'ipfs_cid']);
        });

        Schema::table('barangay_building_clearances', function (Blueprint $table) {
            $table->dropColumn(['document_hash', 'ipfs_cid']);
        });

        Schema::table('residents', function (Blueprint $table) {
            $table->dropColumn(['document_hash', 'ipfs_cid']);
        });
    }
};