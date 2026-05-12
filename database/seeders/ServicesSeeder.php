<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ServicesSeeder extends Seeder
{
    public function run(): void
    {
        $services = [
            [
                'name' => 'Barangay Clearance',
                'description' => 'Obtain a clearance certificate from Barangay West Rembo.',
                'requirements' => "Valid ID\nProof of residence\nClearance application form",
                'processing_time' => '1 business day',
                'fee' => '25',
            ],
            [
                'name' => 'Business Clearance',
                'description' => 'Apply for a business clearance to operate legally in Barangay West Rembo.',
                'requirements' => "Business permit\nValid ID\nCompleted application form",
                'processing_time' => '2-3 business days',
                'fee' => '500',
            ],
            [
                'name' => 'Building Clearance',
                'description' => 'Obtain building clearance for construction or renovation.',
                'requirements' => "Building permit\nID of applicant\nApplication form",
                'processing_time' => '3-5 business days',
                'fee' => '1000',
            ],
            [
                'name' => 'Barangay Certificate',
                'description' => 'Get official certification from Barangay West Rembo.',
                'requirements' => "Valid ID\nPurpose of certificate\nApplication form",
                'processing_time' => '1-2 business days',
                'fee' => 'Free',
            ],
        ];

        foreach ($services as $service) {
            DB::table('services')->updateOrInsert(
                ['name' => $service['name']], // unique check
                array_merge($service, [
                    'updated_at' => now(),
                    'created_at' => now()
                ])
            );
        }
    }
}