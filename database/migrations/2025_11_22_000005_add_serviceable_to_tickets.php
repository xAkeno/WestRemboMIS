<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::table('tickets', function (Blueprint $table) {
            $table->unsignedBigInteger('serviceable_id')->nullable()->index();
            $table->string('serviceable_type')->nullable()->index();

            $table->index(['serviceable_type', 'serviceable_id']);
        });
    }

    public function down()
    {
        Schema::table('tickets', function (Blueprint $table) {
            $table->dropIndex(['serviceable_type', 'serviceable_id']);
            $table->dropColumn(['serviceable_id', 'serviceable_type']);
        });
    }
};
