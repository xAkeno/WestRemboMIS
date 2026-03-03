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
        Schema::create('officials', function (Blueprint $table) {
            $table->id();
            $table->string('profile_image')->nullable();
            $table->string('full_name');
            $table->string('position');
            $table->string('committee_role')->nullable();
            $table->string('term')->nullable(); // e.g. 2023-2025
            $table->integer('display_order')->default(0);
            $table->boolean('visible')->default(false); // ✅ new column
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('officials');
    }
};
