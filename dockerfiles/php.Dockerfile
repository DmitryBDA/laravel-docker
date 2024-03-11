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

RUN docker-php-ext-install gd


RUN pecl install redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis

#install xdebug
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && apk add --update linux-headers \
    && pecl install xdebug-3.2.2 \
    && docker-php-ext-enable xdebug \
    && apk del -f .build-deps

COPY xdebug.ini /usr/local/etc/php/conf.d