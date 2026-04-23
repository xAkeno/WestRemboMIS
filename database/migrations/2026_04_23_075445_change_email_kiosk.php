<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (Schema::hasColumn('kiosks', 'email_address')) {
            Schema::table('kiosks', function (Blueprint $table) {
                $table->renameColumn('email_address', 'email');
            });
        }
    }

    public function down(): void
    {
        if (Schema::hasColumn('kiosks', 'email')) {
            Schema::table('kiosks', function (Blueprint $table) {
                $table->renameColumn('email', 'email_address');
            });
        }
    }
};