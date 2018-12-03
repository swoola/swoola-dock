FROM php:7.1-cli-alpine

LABEL maintainer="Fanybook <fanybook@126.com>"

RUN echo -e "#!/bin/sh\n\nls -l --color=auto \"\$@\"" > /bin/ll \
    && chmod 777 /bin/ll

ARG CHANGE_ALPINE_SOURCE=true
RUN if [ ${CHANGE_ALPINE_SOURCE} = true ]; then \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories \
;fi

# dep libpng when php start with gd
RUN apk update \
    && apk upgrade \
    # base
    && apk add --no-cache build-base git \
    # glibc
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-bin-2.28-r0.apk \
    && apk add glibc-2.28-r0.apk --allow-untrusted \
    && apk add glibc-bin-2.28-r0.apk  --allow-untrusted \
    && rm -f glibc-2.28-r0.apk \
    && rm -f glibc-bin-2.28-r0.apk \
    # swoole
    && docker-php-ext-install -j$(nproc) sockets \
    && apk add --no-cache nghttp2-dev postgresql-dev libpq-dev openssh \
    && wget https://github.com/swoole/swoole-src/archive/v4.2.9.tar.gz \
    && tar -xzvf v4.2.9.tar.gz \
    && cd swoole-src-4.2.9 && \
    && phpize \
    # && ./configure --enable-debug-log --enable-sockets --enable-openssl --enable-http2 --enable-mysqlnd --enable-coroutine-postgresql \
    && ./configure --enable-sockets --enable-openssl --enable-http2 --enable-mysqlnd --enable-coroutine-postgresql \
    && make -j$(nproc) \
    && make install \
    && docker-php-ext-enable swoole \
    # gd
    && apk add --no-cache libpng-dev libjpeg-turbo-dev libwebp-dev freetype-dev \
    && docker-php-ext-configure gd --with-jpeg-dir=/usr/include/ --with-webp-dir=/usr/include/ --with-freetype-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    # mcrypt
    && apk add --no-cache libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) mcrypt \
    # bcmath
    && docker-php-ext-install -j$(nproc) bcmath \
    # pdo_mysql
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    # pdo_pgsql
    && docker-php-ext-install -j$(nproc) pdo_pgsql \
    # opcache
    && docker-php-ext-install -j$(nproc) opcache \
    && rm -rf /var/cache/apk/*