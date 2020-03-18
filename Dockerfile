FROM php:7.3.6-fpm-alpine3.9

RUN apk add composer zip libzip-dev libpng-dev autoconf gcc libc-dev make && \
	composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ && \
	docker-php-ext-install pdo_mysql zip gd && \
	cd / && wget http://pecl.php.net/get/xdebug-2.7.0.tgz && \
	tar -zxvf xdebug-2.7.0.tgz && cd xdebug-2.7.0 && \
	phpize && ./configure && make && make install && \
	wget http://pecl.php.net/get/redis-5.1.0.tgz && \
	tar -zxf redis-5.1.0.tgz && cd redis-5.1.0 && \
	phpize && ./configure && make && make install && \
	cd / && rm -rf xdebug* redis*

ADD extension.tar /usr/local/etc/php/conf.d/

EXPOSE 9000
