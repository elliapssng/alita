#!/bin/sh
set -e
# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
    set -- php-fpm "$@"
fi

if [ "$INSTALL" = true ]; then
    echo "*********** INSTALL = true *******************"
    echo "*********** COMPOSER *******************"
    composer install --prefer-dist --no-interaction --no-scripts
    echo "*********** YARN && ENCORE *******************"
    yarn install
    yarn encore dev
    echo "*********** CREATION DES DOSSIERS *******************"
    mkdir -p /srv/alita/var
    mkdir -p /srv/alita/public/upload/pictures
    echo "*********** MAPPAGE DE L'UTILISATEUR VERS WWW-DATA *******************"
    ## Remapping generate folders to match user id when volume is mounted
    if [ "$(id -u www-data)" = "82" ]; then
        deluser --remove-home www-data &&\
        adduser -u "${USER_ID}" -D www-data -s /bin/sh
        chown -h -R "${USER_ID}":"${USER_ID}" \
        /srv/alita/var \
        /srv/alita/public \
        /srv/alita/data \
        /srv/alita/vendor \
        /srv/alita/node_modules
    fi
else
    echo "*********** INSTALL = false *******************"
fi

if [ "$XDEBUG_ENABLED" = true ]; then
    echo "*********** XDEBUG ENABLED *******************"
    cp ./docker/php/conf/php.dev.xdebug.ini "${PHP_INI_DIR}"/conf.d/zz-custom-dev-xdebug-eliberty-php.ini
    echo "zend_extension=xdebug" > "${PHP_INI_DIR}"/conf.d/docker-php-ext-xdebug.ini
else
    echo "*********** XDEBUG DISABLED *******************"
    rm -f "${PHP_INI_DIR}"/conf.d/zz-custom-dev-xdebug-eliberty-php.ini
    rm -f "${PHP_INI_DIR}"/conf.d/docker-php-ext-xdebug.ini
fi

exec "$@"