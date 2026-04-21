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
        // php artisan make:migration add_tin_no_to_official_receipts_table
        Schema::table('official_receipts', function (Blueprint $table) {
            $table->string('tin_no')->nullable()->after('amount');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('official_receipts', function (Blueprint $table) {
            $table->dropColumn('tin_no');
        });
    }
};
