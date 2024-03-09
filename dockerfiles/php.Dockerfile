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

RUN apk add libpng-dev
RUN apk add libzip-dev
RUN apk add --update linux-headers

RUN docker-php-ext-install gd


RUN pecl install redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis

#install xdebug
RUN pecl install xdebug
COPY xdebug.ini "${PHP_INI_DIR}"/conf.d