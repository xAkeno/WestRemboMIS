<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('document_uploads', function (Blueprint $table) {
            $table->id();

            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');

            /*
             * category — broad group the document belongs to
             *   personal_id | business | building
             *
             * type — the specific document slot key, e.g.:
             *   personal_id  → valid_id_front, valid_id_back,
             *                  proof_of_residency, supporting_document
             *   business     → dti_sec_registration, mayors_permit,
             *                  bir_certificate, articles_of_incorporation,
             *                  general_information_sheet
             *   building     → title_or_tct, tax_declaration,
             *                  building_permit, occupancy_permit, lot_plan
             */
            $table->enum('category', ['personal_id', 'business', 'building']);
            $table->string('type');                  // slot key from the frontend

            $table->string('original_filename');
            $table->string('mime_type');
            $table->unsignedBigInteger('file_size'); // bytes
            $table->string('s3_path');               // path returned by Storage::disk('s3')->putFile(...)
            $table->boolean('is_required')->default(false);

            $table->softDeletes();
            $table->timestamps();

            // A user can only have one active upload per document type at a time
            $table->unique(['user_id', 'type', 'deleted_at']);

            $table->index(['user_id', 'category']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('document_uploads');
    }
};