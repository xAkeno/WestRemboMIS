#!/bin/bash
set -e

echo "Running migrations..."
php artisan migrate --force

echo "Seeding StreetSeeder..."
php artisan db:seed --class=StreetSeeder --force

echo "Starting PHP-FPM..."
php-fpm