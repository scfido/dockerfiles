#
# Dockerfile for mantisbt
#

FROM php:7.1.10-apache
LABEL maintainer="scfido <scfido@gmail.com>"

RUN a2enmod rewrite

#如果apt-get访问太慢，可以使用163的国内镜像站。
#ADD http://mirrors.163.com/.help/sources.list.jessie /etc/apt/sources.list

RUN set -xe \
    && apt-get update \
    && apt-get install -y libpng12-dev libjpeg-dev libpq-dev libxml2-dev \
    && docker-php-ext-install mbstring mysqli pgsql soap
    
RUN set -xe \
    && apt-get update && apt-get install -y libpng12-dev libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && rm -rf /var/lib/apt/lists/*


ENV MANTIS_VER 2.7.0
ENV MANTIS_MD5 bd84a7f03c77a68cc63b15faea8c1d78
ENV MANTIS_URL https://ncu.dl.sourceforge.net/project/mantisbt/mantis-stable/${MANTIS_VER}/mantisbt-${MANTIS_VER}.tar.gz
ENV MANTIS_FILE mantisbt.tar.gz

RUN set -xe \
    && curl -fSL ${MANTIS_URL} -o ${MANTIS_FILE} \
    && echo "${MANTIS_MD5}  ${MANTIS_FILE}" | md5sum -c \
    && tar -xz --strip-components=1 -f ${MANTIS_FILE} \
    && rm ${MANTIS_FILE} \
    && chown -R www-data:www-data .

RUN set -xe \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'date.timezone = "Asia/Shanghai"' > /usr/local/etc/php/php.ini
