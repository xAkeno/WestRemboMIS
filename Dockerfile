FROM php:8.2-cli

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
    git unzip zip curl ghostscript \
    libpq-dev libzip-dev libpng-dev libjpeg-dev libfreetype6-dev \
    libgmp-dev libonig-dev libxml2-dev ca-certificates postgresql-client \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_pgsql zip mbstring xml bcmath gd gmp

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# 👇 COPY EVERYTHING FIRST (IMPORTANT FIX)
COPY . .

# Then install composer
RUN composer install \
    --no-dev \
    --no-interaction \
    --prefer-dist \
    --optimize-autoloader

RUN mkdir -p storage bootstrap/cache \
    && chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 10000

CMD ["docker-entrypoint.sh"]