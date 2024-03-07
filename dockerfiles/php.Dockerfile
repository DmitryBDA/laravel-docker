FROM php:8.2-fpm-alpine

WORKDIR /var/www/laravel

# Install system dependencies
RUN apk --no-cache update \
    && apk add --no-cache autoconf g++ make \
    postgresql-dev \
    \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    \
    && docker-php-ext-install pdo_pgsql

RUN pecl install redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis