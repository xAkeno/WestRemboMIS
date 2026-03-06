#!/bin/bash
set -e

echo "Creating storage symlink..."
php artisan storage:link || echo "Link already exists"

echo "Running migrations..."
php artisan migrate --force

echo "Seeding default services..."
php artisan db:seed --class=ServiceSeeder --force || echo "Seeder already run"

echo "Seeding default contact info..."
php artisan db:seed --class=ContactCmsSeeder --force || echo "ContactCmsSeeder already run"


echo "Clearing cache..."
php artisan config:clear
php artisan cache:clear

echo "Starting Laravel server..."
php artisan serve --host=0.0.0.0 --port=${PORT:-10000}