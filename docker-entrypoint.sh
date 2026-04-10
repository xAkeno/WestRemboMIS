#!/bin/bash
set -e

echo "Creating storage symlink..."
php artisan storage:link || echo "Link already exists"

echo "Running migrations..."
php artisan migrate --force

echo "Seeding default services..."
php artisan db:seed --class=ServicesSeeder --force || echo "ServicesSeeder already run"

echo "Seeding street data..."
php artisan db:seed --class=StreetSeeder --force || echo "StreetSeeder already run"

echo "Seeding contact CMS..."
php artisan db:seed --class=ContactCmsSeeder --force || echo "ContactCmsSeeder already run"

echo "Seeding service prices..."
php artisan db:seed --class=ServicePriceSeeder --force || echo "ServicePriceSeeder already run"

echo "Clearing cache..."
php artisan config:clear
php artisan cache:clear

echo "Starting Laravel server..."
php artisan serve --host=0.0.0.0 --port=${PORT:-10000}