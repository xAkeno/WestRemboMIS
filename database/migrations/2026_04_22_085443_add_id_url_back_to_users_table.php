<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            // Only add if it doesn't already exist (safe to run multiple times)
            if (!Schema::hasColumn('users', 'id_url_back')) {
                $table->string('id_url_back')->nullable()->after('id_url');
            }
        });
    }

    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn('id_url_back');
        });
    }
};
