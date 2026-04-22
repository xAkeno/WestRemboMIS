<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::create('kiosks', function (Blueprint $table) {
            $table->bigIncrements('id');

            // ─── Service Identification ───────────────────────────────────────
            $table->string('service_type')->index(); // clearance, certificate, business_clearance, building_clearance
            $table->string('bcert_number', 50)->nullable();       // barangay_clearances, barangay_certificates, barangay_building_clearances
            $table->string('brgy_business_no')->nullable();        // barangay_business_clearances
            $table->string('requester_type')->nullable();          // all tables

            // ─── Personal Info ────────────────────────────────────────────────
            $table->string('prefix', 10)->nullable();
            $table->string('first_name', 100);
            $table->string('middle_name', 100)->nullable();
            $table->string('surname', 100);
            $table->string('ext_name', 10)->nullable();            // extension / suffix (Jr., Sr., III, etc.)
            $table->string('nick_name')->nullable();               // residents

            // ─── Demographics ─────────────────────────────────────────────────
            $table->string('sex')->nullable();                     // residents
            $table->string('marital_status')->nullable();          // residents
            $table->string('name_of_spouse')->nullable();          // residents
            $table->date('date_of_birth')->nullable();
            $table->string('place_of_birth', 150)->nullable();
            $table->integer('age')->nullable();                    // barangay_certificates
            $table->string('blood_type')->nullable();              // residents
            $table->integer('height_cm')->nullable();              // residents
            $table->integer('weight_kg')->nullable();              // residents
            $table->string('complexion')->nullable();              // residents
            $table->string('religion')->nullable();                // residents

            // ─── Address ─────────────────────────────────────────────────────
            $table->string('house_block_lot_no', 50)->nullable();
            $table->string('street', 100)->nullable();
            $table->string('zone', 50)->nullable();

            // ─── Residency & Voter Info ───────────────────────────────────────
            $table->string('period_of_residency', 50)->nullable();
            $table->string('registered_voter', 20)->nullable();
            $table->string('voter_status')->nullable();            // residents
            $table->string('precinct_no')->nullable();             // residents
            $table->string('house_owner', 100)->nullable();
            $table->string('relationship_to_owner', 50)->nullable();
            $table->string('resident_status')->nullable();         // residents

            // ─── Contact ─────────────────────────────────────────────────────
            $table->string('contact_no', 20)->nullable();
            $table->string('email_address')->nullable();           // residents

            // ─── Employment / PWD ─────────────────────────────────────────────
            $table->string('emp_status')->nullable();              // residents
            $table->string('occupation')->nullable();              // residents
            $table->string('position')->nullable();                // residents
            $table->string('pwd')->nullable();                     // residents

            // ─── Purpose (Clearances / Certificates) ─────────────────────────
            $table->string('purpose', 100)->nullable();
            $table->text('purpose_details')->nullable();

            // ─── Business Clearance Fields ────────────────────────────────────
            $table->string('business_name')->nullable();
            $table->string('business_type')->nullable();
            $table->text('business_details')->nullable();
            $table->decimal('capital', 15, 2)->nullable();

            // ─── Building Clearance Fields ────────────────────────────────────
            $table->string('establishment')->nullable();

            // ─── Inspection Fields (Business Clearance) ───────────────────────
            $table->string('inspected_by')->nullable();
            $table->date('date_of_inspection')->nullable();
            $table->text('inspection_remarks')->nullable();
            $table->text('inspected_remarks')->nullable();
            $table->date('date_inspected')->nullable();
            $table->text('inspected_note')->nullable();

            // ─── CTC / OR / Issuance ─────────────────────────────────────────
            $table->string('ctc_vrr_no')->nullable();              // barangay_clearances
            $table->string('or_no')->nullable();
            $table->string('issued_at')->nullable();               // barangay_clearances
            $table->date('issued_on')->nullable();                 // barangay_clearances
            $table->date('issued_date')->nullable();
            $table->timestamp('expires_at')->nullable();

            // ─── Punong Barangay (Certificates / Building Clearances) ─────────
            $table->string('punong_barangay', 100)->nullable();
            $table->string('for_the_punong_barangay', 100)->nullable();
            $table->string('barangay_position')->nullable();       // barangay_building_clearances

            // ─── Remarks / Notes ──────────────────────────────────────────────
            $table->string('remarks')->nullable();
            $table->text('notes')->nullable();                     // residents
            $table->string('photo')->nullable();                   // residents

            // ─── Kiosk Queue ──────────────────────────────────────────────────
            $table->string('priority')->default('Normal')->index();
            $table->string('authorized_person')->nullable();

            // ─── Status & Document Release ────────────────────────────────────
            $table->string('status', 50)->default('ENCODED')->index();
            $table->string('released_document_path')->nullable();
            $table->timestamp('released_at')->nullable();

            // ─── Audit ───────────────────────────────────────────────────────
            $table->unsignedBigInteger('created_by')->nullable()->index();
            $table->unsignedBigInteger('updated_by')->nullable()->index();
            $table->timestamps();

            $table->foreign('created_by')->references('id')->on('users')->onDelete('set null');
            $table->foreign('updated_by')->references('id')->on('users')->onDelete('set null');
        });
    }

    public function down()
    {
        Schema::dropIfExists('kiosks');
    }
};