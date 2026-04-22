<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration {
    public function up()
    {
        Schema::create('tickets', function (Blueprint $table) {
            $table->bigIncrements('id');

            // ✅ EXISTING
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

            // ✅ ADDED QUEUE FEATURES
            $table->enum('type', ['scheduled', 'same_day', 'walk_in', 'online'])->nullable();

            $table->unsignedTinyInteger('missed_attempts')->default(0);
            $table->timestamp('called_at')->nullable();
            $table->timestamp('arrived_at')->nullable();

            $table->integer('position')->default(0);
            $table->date('queue_date')->default(DB::raw('CURRENT_DATE'));

            $table->timestamps();

            // ✅ INDEX FOR QUEUE
            $table->index(['queue_date', 'status', 'position']);

            // ✅ FOREIGN KEYS
            $table->foreign('requester_id')
                  ->references('id')->on('users')
                  ->onDelete('set null');

            $table->foreign('processed_by')
                  ->references('id')->on('users')
                  ->onDelete('set null');
        });
    }

    public function down()
    {
        Schema::dropIfExists('tickets');
    }
};