FROM php:8.2.16RC1-cli-alpine3.19

ADD extensions.tar.gz /usr/local/lib/php/extensions/no-debug-non-zts-20220829/

RUN	apk add libstdc++ --no-cache && \
    echo "extension=swoole.so" > /usr/local/etc/php/conf.d/swoole.ini && \
    echo "extension=pdo_mysql.so" > /usr/local/etc/php/conf.d/pdo_mysql.ini
