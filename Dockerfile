FROM php:7.3.6-fpm-alpine3.9

RUN apk add composer && \
	composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ && \
	docker-php-ext-install pdo_mysql && \
	apk add libzip-dev && docker-php-ext-install zip

EXPOSE 9000
