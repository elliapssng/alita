ARG PHP_VERSION
ARG ALPINE_VERSION

FROM php:${PHP_VERSION}-fpm-alpine${ALPINE_VERSION}

COPY --from=mlocati/php-extension-installer:1.4.17 /usr/bin/install-php-extensions /usr/bin/

RUN install-php-extensions \
    bcmath \
    gd \
    intl \
    pdo_pgsql

RUN apk add zsh \
    curl \
    wget \
    git \
    htop \
    composer \
    vim

COPY ./conf/www.conf /usr/local/etc/php-fpm.d/

RUN sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
RUN /bin/zsh

ADD ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint
ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]

RUN mv /etc/php8/php.ini /etc/php8/php.ini.bak
ADD ./conf/php.ini /etc/php8/php.ini

ENV COMPOSER_ALLOW_SUPERUSER 1

EXPOSE 9000

WORKDIR /srv/alita/

CMD ["php-fpm"]