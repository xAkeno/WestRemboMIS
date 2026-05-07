<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('barangay_certificates', function (Blueprint $table) {
            $table->string('downloaded_document_path')->nullable();
            $table->string('downloaded_document_hash')->nullable();
            $table->string('downloaded_ipfs_cid')->nullable();
            $table->timestamp('downloaded_at')->nullable();
        });

        Schema::table('barangay_clearances', function (Blueprint $table) {
            $table->string('downloaded_document_path')->nullable();
            $table->string('downloaded_document_hash')->nullable();
            $table->string('downloaded_ipfs_cid')->nullable();
            $table->timestamp('downloaded_at')->nullable();
        });

        Schema::table('barangay_business_clearances', function (Blueprint $table) {
            $table->string('downloaded_document_path')->nullable();
            $table->string('downloaded_document_hash')->nullable();
            $table->string('downloaded_ipfs_cid')->nullable();
            $table->timestamp('downloaded_at')->nullable();
        });

        Schema::table('barangay_building_clearances', function (Blueprint $table) {
            $table->string('downloaded_document_path')->nullable();
            $table->string('downloaded_document_hash')->nullable();
            $table->string('downloaded_ipfs_cid')->nullable();
            $table->timestamp('downloaded_at')->nullable();
        });
    }

    public function down(): void
    {
        $columns = [
            'downloaded_document_path',
            'downloaded_document_hash',
            'downloaded_ipfs_cid',
            'downloaded_at',
        ];

        foreach ([
            'barangay_certificates',
            'barangay_clearances',
            'barangay_business_clearances',
            'barangay_building_clearances',
        ] as $tableName) {
            Schema::table($tableName, function (Blueprint $table) use ($columns) {
                $table->dropColumn($columns);
            });
        }
    }
};
