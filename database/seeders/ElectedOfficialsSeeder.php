<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ElectedOfficialsSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('elected_officials')->insert([
            [
                'profile_image' => 'profile_images/leo.jpg',
                'full_name' => 'Kapitan LEO BES',
                'position' => 'PUNONG BARANGAY',
                'committee_role' => 'Executive / Administration',
                'term' => null,
                'display_order' => 1,
                'visible' => 1,
            ],
            [
                'profile_image' => 'profile_images/agagon.jpg',
                'full_name' => 'Kagawad JAM Agagon',
                'position' => 'Kagawad',
                'committee_role' => 'Peace and Order',
                'term' => null,
                'display_order' => 2,
                'visible' => 1,
            ],
            [
                'profile_image' => 'profile_images/advincula.jpg',
                'full_name' => 'Kagawad Joel Advincula',
                'position' => 'Kagawad',
                'committee_role' => 'Infrastructure / Public Works',
                'term' => null,
                'display_order' => 3,
                'visible' => 1,
            ],
            [
                'profile_image' => 'profile_images/beng.jpg',
                'full_name' => 'Kag. Tess Ygat Cardinal',
                'position' => 'Kagawad',
                'committee_role' => 'Health and Sanitation',
                'term' => null,
                'display_order' => 4,
                'visible' => 1,
            ],
            [
                'profile_image' => 'profile_images/jarabata.jpg',
                'full_name' => 'Kagawad Jose Danny Jarabata',
                'position' => 'Kagawad',
                'committee_role' => 'Education',
                'term' => null,
                'display_order' => 5,
                'visible' => 1,
            ],
            [
                'profile_image' => 'profile_images/mGKFCHPnqLJJ7QsmEXwkjuQQYBkjhQNhQmU0CFjF.jpg',
                'full_name' => 'Kag. Mila Del Rosario',
                'position' => 'Kagawad',
                'committee_role' => 'Women and Family',
                'term' => null,
                'display_order' => 6,
                'visible' => 1,
            ],
            [
                'profile_image' => 'profile_images/neri.jpg',
                'full_name' => 'Kag. Rhod Neri',
                'position' => 'Kagawad',
                'committee_role' => 'Youth and Sports',
                'term' => null,
                'display_order' => 7,
                'visible' => 1,
            ],
            [
                'profile_image' => 'profile_images/bing.jpg',
                'full_name' => 'Kagawad Consuelo Bing Neri',
                'position' => 'Kagawad',
                'committee_role' => 'Social Services',
                'term' => null,
                'display_order' => 8,
                'visible' => 1,
            ],
            [
                'profile_image' => 'profile_images/cardinez.jpg',
                'full_name' => 'Treas. Lorna Cardinez',
                'position' => 'Treasurer',
                'committee_role' => 'Finance',
                'term' => null,
                'display_order' => 9,
                'visible' => 1,
            ],
        ]);
    }
}