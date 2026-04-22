<?php
    // database/seeders/SettingSeeder.php

    namespace Database\Seeders;

    use Illuminate\Database\Seeder;
    use App\Models\Setting;

    class SettingSeeder extends Seeder
    {
        public function run(): void
        {
            $data = [
                'maintenance_mode' => 'false',
                'maintenance_message' => 'System updating',
                'vacation_mode' => 'false',
                'vacation_start' => '2026-05-01',
                'vacation_end' => '2026-05-05',
            ];

            foreach ($data as $key => $value) {
                Setting::updateOrCreate(
                    ['key' => $key],
                    ['value' => $value]
                );
            }
        }
    }
?>