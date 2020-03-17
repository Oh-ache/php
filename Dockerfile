FROM php:7.3.6-fpm-alpine3.9

RUN apk add composer zip libzip-dev libpng-dev autoconf gcc libc-dev make && \
	composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ && \
	docker-php-ext-install pdo_mysql zip gd && \
	cd / && wget http://pecl.php.net/get/xdebug-2.6.1.tgz && \
	tar -zxvf xdebug-2.6.1.tgz && cd xdebug-2.6.1 && \
	phpize && ./configure && make && make install && \
	cd / && rm -rf xdebug*

COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

EXPOSE 9000
