<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::create('tickets', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('ticket_number')->unique();
            $table->string('service_type')->index();
            $table->unsignedBigInteger('requester_id')->nullable()->index();
            $table->string('status')->default('Pending')->index();
            $table->string('priority')->default('Normal')->index();
            $table->timestamp('submitted_at')->nullable()->index();

            $table->unsignedBigInteger('processed_by')->nullable()->index();
            $table->timestamp('in_progress_at')->nullable();
            $table->timestamp('approved_at')->nullable();
            $table->timestamp('rejected_at')->nullable();
            $table->timestamp('released_at')->nullable();

            $table->timestamps();

            $table->foreign('requester_id')->references('id')->on('users')->onDelete('set null');
            $table->foreign('processed_by')->references('id')->on('users')->onDelete('set null');
        });
    }

    public function down()
    {
        Schema::dropIfExists('tickets');
    }
};
