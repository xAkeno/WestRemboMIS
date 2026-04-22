<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('backup_settings', function (Blueprint $table) {
            $table->tinyInteger('day_of_week')
                ->nullable()
                ->comment('0=Sunday, 1=Monday, ..., 6=Saturday (used only for weekly backups)')
                ->after('time');
        });
    }

    public function down(): void
    {
        Schema::table('backup_settings', function (Blueprint $table) {
            $table->dropColumn('day_of_week');
        });
    }
};