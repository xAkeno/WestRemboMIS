<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::create('kiosks', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('service_type')->index();
            $table->string('first_name');
            $table->string('surname');
            $table->string('middle_name')->nullable();
            $table->string('authorized_person')->nullable();
            $table->text('address')->nullable();
            $table->date('date_of_birth')->nullable();
            $table->string('place_of_birth')->nullable();
            $table->string('period_of_residency')->nullable();
            $table->string('registered_voter')->nullable();
            $table->string('house_owner')->nullable();
            $table->string('relation_to_house_owner')->nullable();
            $table->string('contact_number')->nullable();
            $table->text('purpose')->nullable();
            $table->string('priority')->default('Normal')->index();
            // $table->unsignedBigInteger('operator_id')->nullable()->index();
            $table->timestamps();

            // $table->foreign('operator_id')->references('id')->on('users')->onDelete('set null');
        });
    }

    public function down()
    {
        Schema::dropIfExists('kiosks');
    }
};
