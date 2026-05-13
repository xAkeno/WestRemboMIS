<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class ScheduleSlotSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Optional: clear old records
        DB::table('schedule_slots')->truncate();

        $documentTypes = [
            'barangay_certificate',
            'barangay_clearance',
            'business_clearance',
            'building_clearance',
        ];

        $timeSlots = [
            '07:00:00',
            '08:00:00',
            '09:00:00',
            '10:00:00',
            '11:00:00',
            '12:00:00',
            '13:00:00',
            '14:00:00',
            '15:00:00',
            '16:00:00',
            '17:00:00',
        ];

        $data = [];

        foreach ($documentTypes as $documentType) {
            foreach ($timeSlots as $time) {
                $data[] = [
                    'document_type' => $documentType,
                    'schedule_time' => $time,
                    'max_slots' => 10,
                    'created_at' => Carbon::now(),
                    'updated_at' => Carbon::now(),
                ];
            }
        }

        DB::table('schedule_slots')->insert($data);
    }
}