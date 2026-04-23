<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\ContactCms;

class ContactCmsSeeder extends Seeder
{
    public function run(): void
    {
        ContactCms::updateOrCreate(
            ['id' => 27], // check existing record
            [
                'address' => 'Plaza Drive A. Mabini Street (21st), Barangay West Rembo, Taguig City',
                'email' => 'leobes27@gmail.com',
                'telephone' => '(02) 8836 9731 / (02) 8836 9732 / (02) 8836 9733',
                'facebook' => 'https://www.facebook.com/KapLeoBes',
                'office_days' => 'Monday–Saturday',
                'office_hours' => '5:00 AM – 6:00 PM'
            ]
        );
    }
}