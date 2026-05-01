FROM php:8.2-cli

WORKDIR /var/www/html

# =========================
# System dependencies
# =========================
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    unzip \
    zip \
    curl \
    ghostscript \
    libpq-dev \
    libzip-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libgmp-dev \
    libxml2-dev \
    ca-certificates \
    postgresql-client-15 \
    && rm -rf /var/lib/apt/lists/*

# =========================
# Composer
# =========================
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_MEMORY_LIMIT=-1

# =========================
# Copy composer first
# =========================
COPY composer.json composer.lock ./

# temp env fix
RUN cp .env.example .env || true

RUN composer install \
    --no-dev \
    --no-interaction \
    --prefer-dist \
    --optimize-autoloader \
    -vvv

# =========================
# Copy rest of project
# =========================
COPY . .

# =========================
# Permissions
# =========================
RUN mkdir -p storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# =========================
# Entrypoint
# =========================
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 10000

CMD ["docker-entrypoint.sh"]