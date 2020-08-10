FROM php:7.4.5-fpm-alpine

RUN	apk add composer zip libzip-dev libpng-dev autoconf gcc libc-dev libjpeg-turbo-dev freetype-dev make g++ rabbitmq-c-dev libsodium-dev libmcrypt-dev unzip gmp-dev --no-cache && \
	composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ && \
	docker-php-ext-configure gd --with-jpeg --with-freetype && \
	docker-php-ext-install pdo_mysql mysqli zip gd sockets gmp pcntl bcmath
RUN	cd / && wget https://github.com/swoole/sdebug/archive/sdebug_2_9.zip && \
	unzip sdebug_2_9.zip && cd sdebug-sdebug_2_9 && \
	phpize && ./configure --enable-xdebug && make && make install && \
	cd / && wget http://pecl.php.net/get/redis-5.1.0.tgz && \
	tar -zxf redis-5.1.0.tgz && cd redis-5.1.0 && \
	phpize && ./configure && make && make install && \
	cd / && wget http://pecl.php.net/get/swoole-4.4.16.tgz && \
	tar -zxf swoole-4.4.16.tgz && cd swoole-4.4.16 && \
	phpize && ./configure --enable-openssl && make && make install && \
	cd / && wget http://pecl.php.net/get/yaconf-1.1.0.tgz && \
	tar -zxf yaconf-1.1.0.tgz && cd yaconf-1.1.0 && \
	phpize && ./configure && make && make install && \
	cd / && wget http://pecl.php.net/get/amqp-1.10.2.tgz && \
	tar -zxvf amqp-1.10.2.tgz && cd amqp-1.10.2 && \
	phpize && ./configure && make && make install && \
	cd / && wget http://pecl.php.net/get/libsodium-2.0.22.tgz && \
	tar -zxvf libsodium-2.0.22.tgz && cd libsodium-2.0.22 && \
	phpize && ./configure && make && make install && \
	cd / && wget http://pecl.php.net/get/mcrypt-1.0.3.tgz && \
	tar -zxvf mcrypt-1.0.3.tgz && cd mcrypt-1.0.3 && \
	phpize && ./configure && make && make install && \
	cd / && wget http://pecl.php.net/get/mongodb-1.7.4.tgz && \
	tar -zxvf mongodb-1.7.4.tgz && cd mongodb-1.7.4 && \
	phpize && ./configure && make && make install && \
	cd / && rm -rf sdebug* redis* swoole* yaconf* amqp* libsodium* mongodb* && \
	sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

ADD extension.tar /usr/local/etc/php/conf.d/

EXPOSE 9000
