FROM php:7.3.6-fpm-alpine3.9

RUN docker-php-ext-install pdo_mysql

EXPOSE 9000
