<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Street;

class StreetSeeder extends Seeder
{
    public function run(): void
    {
        $streets = [
            ['name' => 'A. Bonifacio Street', 'sitio' => 'Sitio 5', 'formerly' => null],
            ['name' => 'A. Bonifacio Street', 'sitio' => 'Sitio 1', 'formerly' => null],
            ['name' => 'A. Luna Street', 'sitio' => 'Sitio 5', 'formerly' => null],
            ['name' => 'A. Mabini Street', 'sitio' => 'Sitio 5', 'formerly' => '21St Street'],
            ['name' => 'Agulan Street corner Baden Powell', 'sitio' => 'Sitio 1', 'formerly' => null],
            ['name' => 'Agulan Street corner T. Alonzo', 'sitio' => 'Sitio 3', 'formerly' => null],
            ['name' => 'Avocado Street', 'sitio' => 'Sitio 2', 'formerly' => null],
            ['name' => 'B. Serrano Street', 'sitio' => 'Sitio 6', 'formerly' => '25th Street'],
            ['name' => 'Balagtas Street', 'sitio' => 'Sitio 3', 'formerly' => '3rd Street'],
            ['name' => 'Banez Street', 'sitio' => 'Sitio 1', 'formerly' => null],
            ['name' => 'Bayabas Street', 'sitio' => 'Sitio 2', 'formerly' => null],
            ['name' => 'Black 4 Extension', 'sitio' => 'Sitio 1', 'formerly' => null],
            ['name' => 'Block 4', 'sitio' => 'Sitio 1', 'formerly' => null],
            ['name' => 'Block 5', 'sitio' => 'Sitio 8', 'formerly' => null],
            ['name' => 'Block 6', 'sitio' => 'Sitio 8', 'formerly' => null],
            ['name' => 'Block 7', 'sitio' => 'Sitio 8', 'formerly' => null],
            ['name' => 'Block 8', 'sitio' => 'Sitio 2', 'formerly' => null],
            ['name' => 'Caimito Street', 'sitio' => 'Sitio 2', 'formerly' => null],
            ['name' => 'Crisolo Street', 'sitio' => 'Sitio 1', 'formerly' => null],
            ['name' => 'Dagohoy Street', 'sitio' => 'Sitio 3', 'formerly' => '7th Street'],
            ['name' => 'Dalandan Street', 'sitio' => 'Sitio 2', 'formerly' => null],
            ['name' => 'E. Aguinaldo Street', 'sitio' => 'Sitio 3', 'formerly' => '1st Street'],
            ['name' => 'E. Jacinto Street', 'sitio' => 'Sitio 4', 'formerly' => '13th Street'],
            ['name' => 'G.L. Jaena Street', 'sitio' => 'Sitio 4', 'formerly' => '17th Street'],
            ['name' => 'Gen. Arellano Street', 'sitio' => 'Sitio 1', 'formerly' => null],
            ['name' => 'Hidalgo Street', 'sitio' => 'Sitio 3', 'formerly' => null],
            ['name' => 'Hill Top Street', 'sitio' => 'Sitio 7', 'formerly' => null],
            ['name' => 'J. Burgos Street', 'sitio' => 'Sitio 3', 'formerly' => '5th Street'],
            ['name' => 'J.P Rizal Extension', 'sitio' => null, 'formerly' => null],
            ['name' => 'Jail side Street', 'sitio' => 'Sitio 1', 'formerly' => null],
            ['name' => 'Kalayaan Avenue', 'sitio' => 'Sitio 8', 'formerly' => null],
            ['name' => 'KKK Talipapa Street', 'sitio' => 'Sitio 3', 'formerly' => null],
            ['name' => 'Langka Street', 'sitio' => 'Sitio 2', 'formerly' => null],
            ['name' => 'Lapu-Lapu Street', 'sitio' => 'Sitio 4', 'formerly' => '15th Street'],
            ['name' => 'Lariosa Street', 'sitio' => 'Sitio 1', 'formerly' => null],
            ['name' => 'M. Corpuz Street', 'sitio' => 'Sitio 1', 'formerly' => null],
            ['name' => 'Malvar Street, River Side, J.P. Rizal Extension', 'sitio' => 'Sitio 5', 'formerly' => null],
            ['name' => 'Mangga Street Block 678', 'sitio' => 'Sitio 2', 'formerly' => null],
            ['name' => 'Mansanas Street', 'sitio' => 'Sitio 2', 'formerly' => null],
            ['name' => 'Matabuena Street', 'sitio' => 'Sitio 5', 'formerly' => null],
            ['name' => 'Matatag Street', 'sitio' => 'Sitio 5', 'formerly' => null],
            ['name' => 'MP Compound Street', 'sitio' => 'Sitio 1', 'formerly' => null],
            ['name' => 'Napindan Site Street', 'sitio' => 'Sitio 6', 'formerly' => null],
            ['name' => 'P. Gomez Street', 'sitio' => 'Sitio 4', 'formerly' => null],
            ['name' => 'Panday Pira Street', 'sitio' => 'Sitio 6', 'formerly' => '23rd Street'],
            ['name' => 'Papaya Street', 'sitio' => 'Sitio 2', 'formerly' => null],
            ['name' => 'Pili Avenue', 'sitio' => 'Sitio 2', 'formerly' => null],
            ['name' => 'Pio Del Pilar Street', 'sitio' => 'Sitio 3', 'formerly' => '9th Street'],
            ['name' => 'Recarte Street', 'sitio' => 'Sitio 6', 'formerly' => '2nd Street'],
            ['name' => 'Sino Cruz Street', 'sitio' => 'Sitio 2', 'formerly' => null],
            ['name' => 'Sir. Baden Powell Street', 'sitio' => 'Sitio 1', 'formerly' => null],
            ['name' => 'Suha Street', 'sitio' => 'Sitio 2', 'formerly' => null],
            ['name' => 'T. Alonzo Street', 'sitio' => 'Sitio 1', 'formerly' => null],
            ['name' => 'Teachers Compound Street', 'sitio' => 'Sitio 1', 'formerly' => null],
            ['name' => 'Upper Plaza (Proper)', 'sitio' => 'Sitio 7', 'formerly' => null],
            ['name' => 'Upper Plaza (Suha)', 'sitio' => 'Sitio 7', 'formerly' => null],
            ['name' => 'Urduja Street', 'sitio' => 'Sitio 6', 'formerly' => '31st Street'],
            ['name' => 'Zamora Street', 'sitio' => 'Sitio 6', 'formerly' => '33rd Street'],
        ];

        foreach ($streets as $street) {
            Street::firstOrCreate(
                ['name' => $street['name'], 'sitio' => $street['sitio']],
                $street
            );
        }
    }
}