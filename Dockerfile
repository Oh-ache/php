FROM php:7.3.6-fpm-alpine3.9

RUN docker-php-ext-install pdo_mysql && \
	apk add zip-dev libzip-dev && docker-php-ext-install libzip

EXPOSE 9000
