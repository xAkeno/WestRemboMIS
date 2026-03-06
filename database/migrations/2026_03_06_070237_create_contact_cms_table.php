<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('contact_cms', function (Blueprint $table) {
            $table->id();
            $table->string('address');
            $table->string('email');
            $table->string('telephone');
            $table->string('facebook')->nullable();
            $table->string('office_days')->nullable(); // e.g., Monday–Saturday
            $table->string('office_hours')->nullable(); // e.g., 5:00 AM – 6:00 PM
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('contact_cms');
    }
};