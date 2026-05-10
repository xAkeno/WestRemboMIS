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
        Schema::table('users', function (Blueprint $table) {
            $table->string('parent_id_url')->nullable()->after('id_url_back');
            $table->string('parent_id_url_back')->nullable()->after('parent_id_url');
            
            // ← NEW: Track ID type and dependent status
            $table->string('id_type')->nullable()->after('parent_id_url_back')->default(null); // national_id, sss, philhealth, school_id, drivers_license, pwd_id
            $table->boolean('is_dependent')->nullable()->after('id_type')->default(false);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn([
                'parent_id_url',
                'parent_id_url_back',
                'id_type',
                'is_dependent',
            ]);
        });
    }
};
