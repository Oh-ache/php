FROM php:7.4.5-fpm-alpine

RUN	apk add composer zip libzip-dev libpng-dev autoconf gcc libc-dev libjpeg-turbo-dev freetype-dev make g++ rabbitmq-c-dev --no-cache && \
	composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ && \
	docker-php-ext-configure gd --with-jpeg --with-freetype && \
	docker-php-ext-install pdo_mysql zip gd && \
	cd / && wget http://pecl.php.net/get/xdebug-2.9.5.tgz && \
	tar -zxvf xdebug-2.9.5.tgz && cd xdebug-2.9.5 && \
	phpize && ./configure && make && make install && \
	wget http://pecl.php.net/get/redis-5.1.0.tgz && \
	tar -zxf redis-5.1.0.tgz && cd redis-5.1.0 && \
	phpize && ./configure && make && make install && \
	cd / && wget http://pecl.php.net/get/swoole-4.4.16.tgz && \
	tar -zxf swoole-4.4.16.tgz && cd swoole-4.4.16 && \
	phpize && ./configure && make && make install && \
	cd / && wget http://pecl.php.net/get/yaconf-1.1.0.tgz && \
	tar -zxf yaconf-1.1.0.tgz && cd yaconf-1.1.0 && \
	phpize && ./configure && make && make install && \
	wget http://pecl.php.net/get/amqp-1.10.2.tgz && \
	tar -zxvf amqp-1.10.2.tgz && cd amqp-1.10.2 && \
	phpize && ./configure && make && make install && \
	cd / && rm -rf xdebug* redis* swoole* yaconf* amqp-1.10.2* && \

ADD extension.tar /usr/local/etc/php/conf.d/

EXPOSE 9000
