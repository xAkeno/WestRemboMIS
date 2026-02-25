<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Street;

class StreetSeeder extends Seeder
{
    public function run(): void
    {
        $streets = [
            ['id' => 58, 'name' => 'A. Bonifacio Street', 'sitio' => 'Sitio 5', 'formerly' => ''],
            ['id' => 12, 'name' => 'A. Bonifacio Street', 'sitio' => 'Sitio 1', 'formerly' => ''],
            ['id' => 42, 'name' => 'A. Luna Street', 'sitio' => 'Sitio 5', 'formerly' => ''],
            ['id' => 40, 'name' => 'A. Mabini Street', 'sitio' => 'Sitio 5', 'formerly' => '21St Street'],
            ['id' => 7, 'name' => 'Agulan Street corner Baden Powell', 'sitio' => 'Sitio 1', 'formerly' => ''],
            ['id' => 27, 'name' => 'Agulan Street corner T. Alonzo', 'sitio' => 'Sitio 3', 'formerly' => ''],
            ['id' => 20, 'name' => 'Avocado Street', 'sitio' => 'Sitio 2', 'formerly' => ''],
            ['id' => 45, 'name' => 'B. Serrano Street', 'sitio' => 'Sitio 6', 'formerly' => '25th Street'],
            ['id' => 30, 'name' => 'Balagtas Street', 'sitio' => 'Sitio 3', 'formerly' => '3rd Street'],
            ['id' => 9, 'name' => 'Banez Street', 'sitio' => 'Sitio 1', 'formerly' => ''],
            ['id' => 17, 'name' => 'Bayabas Street', 'sitio' => 'Sitio 2', 'formerly' => ''],
            ['id' => 14, 'name' => 'Black 4 Extension', 'sitio' => 'Sitio 1', 'formerly' => ''],
            ['id' => 11, 'name' => 'Block 4', 'sitio' => 'Sitio 1', 'formerly' => ''],
            ['id' => 54, 'name' => 'Block 5', 'sitio' => 'Sitio 8', 'formerly' => ''],
            ['id' => 55, 'name' => 'Block 6', 'sitio' => 'Sitio 8', 'formerly' => ''],
            ['id' => 56, 'name' => 'Block 7', 'sitio' => 'Sitio 8', 'formerly' => ''],
            ['id' => 57, 'name' => 'Block 8', 'sitio' => 'Sitio 2', 'formerly' => ''],
            ['id' => 18, 'name' => 'Caimito Street', 'sitio' => 'Sitio 2', 'formerly' => ''],
            ['id' => 13, 'name' => 'Crisolo Street', 'sitio' => 'Sitio 1', 'formerly' => ''],
            ['id' => 32, 'name' => 'Dagohoy Street', 'sitio' => 'Sitio 3', 'formerly' => '7th Street'],
            ['id' => 26, 'name' => 'Dalandan Street', 'sitio' => 'Sitio 2', 'formerly' => ''],
            ['id' => 29, 'name' => 'E. Aguinaldo Street', 'sitio' => 'Sitio 3', 'formerly' => '1st Street'],
            ['id' => 35, 'name' => 'E. Jacinto Street', 'sitio' => 'Sitio 4', 'formerly' => '13th Street'],
            ['id' => 37, 'name' => 'G.L. Jaena Street', 'sitio' => 'Sitio 4', 'formerly' => '17th Street'],
            ['id' => 1, 'name' => 'Gen. Arellano Street', 'sitio' => 'Sitio 1', 'formerly' => ''],
            ['id' => 28, 'name' => 'Hidalgo Street', 'sitio' => 'Sitio 3', 'formerly' => ''],
            ['id' => 50, 'name' => 'Hill Top Street', 'sitio' => 'Sitio 7', 'formerly' => ''],
            ['id' => 31, 'name' => 'J. Burgos Street', 'sitio' => 'Sitio 3', 'formerly' => '5th Street'],
            ['id' => 59, 'name' => 'J.P Rizal Extension', 'sitio' => '', 'formerly' => ''],
            ['id' => 6, 'name' => 'Jail side Street', 'sitio' => 'Sitio 1', 'formerly' => ''],
            ['id' => 53, 'name' => 'Kalayaan Avenue', 'sitio' => 'Sitio 8', 'formerly' => ''],
            ['id' => 34, 'name' => 'KKK Talipapa Street', 'sitio' => 'Sitio 3', 'formerly' => ''],
            ['id' => 21, 'name' => 'Langka Street', 'sitio' => 'Sitio 2', 'formerly' => ''],
            ['id' => 36, 'name' => 'Lapu-Lapu Street', 'sitio' => 'Sitio 4', 'formerly' => '15th Street'],
            ['id' => 5, 'name' => 'Lariosa Street', 'sitio' => 'Sitio 1', 'formerly' => ''],
            ['id' => 3, 'name' => 'M. Corpuz Street', 'sitio' => 'Sitio 1', 'formerly' => ''],
            ['id' => 41, 'name' => 'Malvar Street, River Side, J.P. Rizal Extension', 'sitio' => 'Sitio 5', 'formerly' => ''],
            ['id' => 15, 'name' => 'Mangga Street Block 678', 'sitio' => 'Sitio 2', 'formerly' => ''],
            ['id' => 25, 'name' => 'Mansanas Street', 'sitio' => 'Sitio 2', 'formerly' => ''],
            ['id' => 39, 'name' => 'Matabuena Street', 'sitio' => 'Sitio 5', 'formerly' => ''],
            ['id' => 38, 'name' => 'Matatag Street', 'sitio' => 'Sitio 5', 'formerly' => ''],
            ['id' => 10, 'name' => 'MP Compound Street', 'sitio' => 'Sitio 1', 'formerly' => ''],
            ['id' => 49, 'name' => 'Napindan Site Street', 'sitio' => 'Sitio 6', 'formerly' => ''],
            ['id' => 16, 'name' => 'P. Gomez Street', 'sitio' => 'Sitio 4', 'formerly' => ''],
            ['id' => 44, 'name' => 'Panday Pira Street', 'sitio' => 'Sitio 6', 'formerly' => '23rd Street'],
            ['id' => 24, 'name' => 'Papaya Street', 'sitio' => 'Sitio 2', 'formerly' => ''],
            ['id' => 22, 'name' => 'Pili Avenue', 'sitio' => 'Sitio 2', 'formerly' => ''],
            ['id' => 33, 'name' => 'Pio Del Pilar Street', 'sitio' => 'Sitio 3', 'formerly' => '9th Street'],
            ['id' => 46, 'name' => 'Recarte Street', 'sitio' => 'Sitio 6', 'formerly' => '2nd Street'],
            ['id' => 23, 'name' => 'Sino Cruz Street', 'sitio' => 'Sitio 2', 'formerly' => ''],
            ['id' => 2, 'name' => 'Sir. Baden Powell Street', 'sitio' => 'Sitio 1', 'formerly' => ''],
            ['id' => 19, 'name' => 'Suha Street', 'sitio' => 'Sitio 2', 'formerly' => ''],
            ['id' => 4, 'name' => 'T. Alonzo Street', 'sitio' => 'Sitio 1', 'formerly' => ''],
            ['id' => 8, 'name' => 'Teachers Compound Street', 'sitio' => 'Sitio 1', 'formerly' => ''],
            ['id' => 51, 'name' => 'Upper Plaza (Proper)', 'sitio' => 'Sitio 7', 'formerly' => ''],
            ['id' => 52, 'name' => 'Upper Plaza (Suha)', 'sitio' => 'Sitio 7', 'formerly' => ''],
            ['id' => 47, 'name' => 'Urduja Street', 'sitio' => 'Sitio 6', 'formerly' => '31st Street'],
            ['id' => 48, 'name' => 'Zamora Street', 'sitio' => 'Sitio 6', 'formerly' => '33rd Street'],
        ];

        foreach ($streets as $street) {
            Street::create($street);
        }
    }
}