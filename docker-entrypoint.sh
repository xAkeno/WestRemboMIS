#!/bin/bash
set -e

echo "Creating storage symlink..."
php artisan storage:link || echo "Link already exists"

echo "Running migrations..."
php artisan migrate --force

echo "Clearing cache..."
php artisan config:clear
php artisan cache:clear

echo "Starting Laravel server..."
php artisan serve --host=0.0.0.0 --port=${PORT:-10000}