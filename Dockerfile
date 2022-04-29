FROM php:7.1.33-fpm-alpine3.10

ADD sdebug_2_9.zip /
ADD extension.tar.gz /usr/local/etc/php/conf.d/
ADD *.tgz  /

RUN	sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
	apk add zip libzip-dev libpng-dev autoconf gcc libc-dev libjpeg-turbo-dev jpeg-dev freetype-dev make g++ rabbitmq-c-dev libsodium-dev libmcrypt-dev gmp-dev libmemcached-dev ca-certificates --no-cache && \
	apk update && apk add tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	echo "Asia/Shanghai" > /etc/timezone && \
	update-ca-certificates && \
	apk del tzdata && \
	docker-php-ext-configure gd --with-jpeg-dir=/usr/lib --with-freetype-dir=/usr/include/freetype2 && \
	docker-php-ext-install pdo_mysql mysqli zip gd sockets gmp pcntl bcmath
RUN curl -sS https://getcomposer.org/installer | php && \
	mv /var/www/html/composer.phar /usr/bin/composer && \
	composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ && \
	cd / && unzip sdebug_2_9.zip && cd sdebug-sdebug_2_9 && phpize && ./configure --enable-xdebug && make && make install && \
	cd /redis-5.1.0 && phpize && ./configure && make && make install && \
	cd /amqp-1.10.2 && phpize && ./configure && make && make install && \
	cd /libsodium-2.0.22 && phpize && ./configure && make && make install && \
	cd /swoole-4.4.16 && phpize && ./configure --enable-openssl && make && make install && \
	cd /mcrypt-1.0.3 && phpize && ./configure && make && make install && \
	cd /mongodb-1.7.4 && phpize && ./configure && make && make install && \
	cd /memcached-3.1.5 && phpize && ./configure && make && make install && \
    cd /xlswriter-1.5.1 && phpize && ./configure && make && make install && \
	cd / && rm -rf redis* amqp* libsodium* mongodb* sdebug*

EXPOSE 9000
