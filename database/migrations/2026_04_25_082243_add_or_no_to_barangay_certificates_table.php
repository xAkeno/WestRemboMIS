<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('barangay_certificates', function (Blueprint $table) {
            $table->string('or_no')->nullable()->after('issued_date');
        });
    }

    public function down(): void
    {
        Schema::table('barangay_certificates', function (Blueprint $table) {
            $table->dropColumn('or_no');
        });
    }
};

