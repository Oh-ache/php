FROM php:7.1.33-fpm-alpine3.10

RUN	sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories && \
	apk add composer zip libzip-dev libpng-dev autoconf gcc libc-dev libjpeg-turbo-dev jpeg-dev freetype-dev make g++ rabbitmq-c-dev libsodium-dev libmcrypt-dev gmp-dev libmemcached-dev --no-cache && \
	apk update && apk add tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	echo "Asia/Shanghai" > /etc/timezone && \
	apk del tzdata && \
	composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ && \
	docker-php-ext-configure gd --with-jpeg-dir=/usr/lib --with-freetype-dir=/usr/include/freetype2 && \
	docker-php-ext-install pdo_mysql mysqli zip gd sockets gmp pcntl bcmath
RUN	cd / && wget https://github.com/swoole/sdebug/archive/sdebug_2_9.zip && \
	unzip sdebug_2_9.zip && cd sdebug-sdebug_2_9 && \
	phpize && ./configure --enable-xdebug && make && make install && \
	cd / && wget http://pecl.php.net/get/redis-5.1.0.tgz && \
	tar -zxf redis-5.1.0.tgz && cd redis-5.1.0 && \
	phpize && ./configure && make && make install && \
	cd / && wget http://pecl.php.net/get/yaconf-1.1.0.tgz && \
	tar -zxf yaconf-1.1.0.tgz && cd yaconf-1.1.0 && \
	phpize && ./configure && make && make install && \
	cd / && wget http://pecl.php.net/get/amqp-1.10.2.tgz && \
	tar -zxvf amqp-1.10.2.tgz && cd amqp-1.10.2 && \
	phpize && ./configure && make && make install && \
	cd / && wget http://pecl.php.net/get/libsodium-2.0.22.tgz && \
	tar -zxvf libsodium-2.0.22.tgz && cd libsodium-2.0.22 && \
	phpize && ./configure && make && make install && \
	cd / && wget http://pecl.php.net/get/swoole-4.4.16.tgz && \
	tar -zxf swoole-4.4.16.tgz && cd swoole-4.4.16 && \
	phpize && ./configure --enable-openssl && make && make install && \
	cd / && wget http://pecl.php.net/get/mcrypt-1.0.3.tgz && \
	tar -zxvf mcrypt-1.0.3.tgz && cd mcrypt-1.0.3 && \
	phpize && ./configure && make && make install && \
	cd / && wget http://pecl.php.net/get/mongodb-1.7.4.tgz && \
	tar -zxvf mongodb-1.7.4.tgz && cd mongodb-1.7.4 && \
	phpize && ./configure && make && make install && \
	cd / && wget http://pecl.php.net/get/memcached-3.1.5.tgz && \
	tar -zxvf memcached-3.1.5.tgz && cd memcached-3.1.5 && \
	phpize && ./configure && make && make install && \
	cd / && rm -rf redis* yaconf* amqp* libsodium* mongodb* sdebug*

ADD extension.tar /usr/local/etc/php/conf.d/

EXPOSE 9000
