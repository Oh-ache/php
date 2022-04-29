FROM php:7.4.5-fpm-alpine

ADD sdebug_2_9.zip /
ADD extension.tar.gz /usr/local/etc/php/conf.d/
ADD *.tgz  /
Add swoftcli /usr/bin/swoftcli
ADD composer.phar /usr/bin/composer

RUN	sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
	apk add zip libzip-dev libpng-dev autoconf gcc libc-dev libjpeg-turbo-dev freetype-dev make g++ rabbitmq-c-dev libsodium-dev libmcrypt-dev unzip gmp-dev --no-cache && \
	docker-php-ext-configure gd --with-jpeg --with-freetype && \
	docker-php-ext-install pdo_mysql mysqli zip gd sockets gmp pcntl bcmath

RUN	composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ && \
	cd / && unzip sdebug_2_9.zip && cd sdebug-sdebug_2_9 && phpize && ./configure --enable-xdebug && make && make install && \
	cd /redis-5.1.0 && phpize && ./configure && make && make install && \
	cd /swoole-4.6.2 && phpize && ./configure --enable-openssl && make && make install && \
	cd /amqp-1.10.2 && phpize && ./configure && make && make install && \
	cd /libsodium-2.0.22 && phpize && ./configure && make && make install && \
	cd /mcrypt-1.0.3 && phpize && ./configure && make && make install && \
	cd /mongodb-1.7.4 && phpize && ./configure && make && make install && \
	cd /xlswriter-1.5.1 && phpize && ./configure && make && make install && \
	cd / && rm -rf sdebug* redis* swoole* amqp* libsodium* mongodb* xlswriter*

EXPOSE 9000
