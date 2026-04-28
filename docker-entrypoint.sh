#!/bin/bash
set -e

echo "▶ Caching config..."
php artisan config:cache

echo "▶ Caching routes..."
php artisan route:cache

echo "▶ Caching views..."
php artisan view:cache

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

echo "▶ Starting Laravel server..."
php artisan serve --host=0.0.0.0 --port=${PORT:-10000}