FROM php:7.3.6-fpm-alpine3.9

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories && \
	apk add composer zip libzip-dev libpng-dev autoconf gcc libc-dev make && \
	composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ && \
	docker-php-ext-install pdo_mysql zip gd && \
	cd / && wget http://pecl.php.net/get/xdebug-2.7.0.tgz && \
	tar -zxvf xdebug-2.7.0.tgz && cd xdebug-2.7.0 && \
	phpize && ./configure && make && make install 

COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

EXPOSE 9000
