#
# Dockerfile for mantisbt
#

FROM php:7.4.2-apache
LABEL maintainer="scfido <scfido@gmail.com>"

RUN a2enmod rewrite

#如果apt-get访问太慢，可以使用163的国内镜像站。
#ADD http://mirrors.163.com/.help/sources.list.jessie /etc/apt/sources.list
ADD sources-tsinghua.list /etc/apt/sources.list

# RUN set -xe \
#     && apt-get update \
#     && apt-get install -y libpng-dev libjpeg-dev libpq-dev libxml2-dev \
#     && docker-php-ext-install mbstring mysqli pgsql soap
    
# RUN set -xe \
#     && apt-get update && apt-get install -y libpng-dev libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev \
#     && docker-php-ext-install -j$(nproc) iconv mcrypt \
#     && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
#     && docker-php-ext-install -j$(nproc) gd \
#     && rm -rf /var/lib/apt/lists/*

RUN set -xe \
    && apt-get update \
    && apt-get install -y libonig-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev libjpeg-dev libpq-dev libxml2-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mbstring mysqli pgsql soap \
    && rm -rf /var/lib/apt/lists/*

ENV MANTIS_VER 2.24.0
ENV MANTIS_SHA1 5e55550bbb48f1af522c638ea0f90eccb1023304
ENV MANTIS_URL https://nchc.dl.sourceforge.net/project/mantisbt/mantis-stable/${MANTIS_VER}/mantisbt-${MANTIS_VER}.tar.gz
ENV MANTIS_FILE mantisbt.tar.gz
ENV MANTIS_TIMEZONE Asia/Shanghai

RUN set -xe \
    && curl -fSL ${MANTIS_URL} -o ${MANTIS_FILE} \
    && echo "${MANTIS_SHA1}  ${MANTIS_FILE}" | sha1sum -c \
    && tar -xz --strip-components=1 -f ${MANTIS_FILE} \
    && rm ${MANTIS_FILE} \
    && chown -R www-data:www-data .

RUN set -xe \
    && ln -sf /usr/share/zoneinfo/${MANTIS_TIMEZONE} /etc/localtime \
    && echo 'date.timezone = "${MANTIS_TIMEZONE}"' > /usr/local/etc/php/php.ini
