<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\ServicePrice;
class ServicePriceSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $types = [
            'barangay_clearance',
            'business_clearance',
            'building_clearance',
            'certificate',
            'resident'
        ];

        foreach ($types as $type) {
            ServicePrice::firstOrCreate(
                ['type' => $type],
                ['amount' => 0]
            );
        }
    }
}
