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
    htop

RUN ln -s /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini \
    && rm /usr/local/etc/php-fpm.d/*.conf

COPY www.conf /usr/local/etc/php-fpm.d/

RUN sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
RUN /bin/zsh

ADD ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]

EXPOSE 9000

WORKDIR /srv/alita/

CMD ["php-fpm"]