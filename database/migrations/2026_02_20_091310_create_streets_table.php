<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('streets', function (Blueprint $table) {
            $table->id(); // Street ID
            $table->string('name'); // Street name
            $table->string('sitio')->nullable(); // Sitio
            $table->string('formerly')->nullable(); // Formerly
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('streets');
    }
};