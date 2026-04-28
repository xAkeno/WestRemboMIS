#!/bin/bash
set -e

echo "▶ Creating required directories..."
mkdir -p /var/www/html/storage/framework/views
mkdir -p /var/www/html/storage/framework/cache
mkdir -p /var/www/html/storage/framework/sessions
mkdir -p /var/www/html/storage/logs
mkdir -p /var/www/html/bootstrap/cache
chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

echo "▶ Caching config..."
php artisan config:cache

echo "▶ Caching routes..."
php artisan route:cache

echo "▶ Running migrations..."
php artisan migrate --force --no-interaction

echo "▶ Seeding default services..."
php artisan db:seed --class=ServicesSeeder --force || echo "ServicesSeeder skipped"

echo "▶ Seeding street data..."
php artisan db:seed --class=StreetSeeder --force || echo "StreetSeeder skipped"

echo "▶ Seeding contact CMS..."
php artisan db:seed --class=ContactCmsSeeder --force || echo "ContactCmsSeeder skipped"

echo "▶ Seeding service prices..."
php artisan db:seed --class=ServicePriceSeeder --force || echo "ServicePriceSeeder skipped"

echo "▶ Seeding settings..."
php artisan db:seed --class=SettingSeeder --force || echo "SettingSeeder skipped"

echo "▶ Seeding elected officials..."
php artisan db:seed --class=ElectedOfficialsSeeder --force || echo "ElectedOfficialsSeeder skipped"

echo "▶ Starting Laravel server..."
php artisan serve --host=0.0.0.0 --port=${PORT:-10000}