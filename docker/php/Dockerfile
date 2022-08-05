ARG PHP_VERSION

FROM php:$PHP_VERSION-fpm
ARG BASE_VERSION=8.1
RUN echo 'deb [trusted=yes] https://repo.symfony.com/apt/ /' | tee /etc/apt/sources.list.d/symfony-cli.list
RUN apt-get update -y && apt-get upgrade -y

RUN echo "**** Installation package initiaux ****"
RUN apt-get install -y \
    curl\
    gnupg\
    vim \
    git \
    wget \
    zip \
    symfony-cli \
    ca-certificates \
    apt-transport-https \
    software-properties-common \
    lsb-release

RUN echo "**** Configuration PHP $BASE_VERSION****"
RUN curl -sSL https://packages.sury.org/php/README.txt | bash -x
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y \
    php$BASE_VERSION-pgsql/bullseye \
    libxslt1-dev \
    php$BASE_VERSION-xml/bullseye \
    php$BASE_VERSION-xsl/bullseye

RUN echo "**** Installation Composer ****"
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

RUN echo "**** Installation NodeJS ****"
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs

RUN echo "**** Installation YARN ****"
RUN apt-get install -y yarn

RUN echo "**** Installation ZSH ****"
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN chsh -s /bin/zsh

ADD ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint
ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]

RUN git config --global user.email "ellia.passinge@gmail.com"
RUN git config --global user.name "Ellia Passinge"

COPY . /srv/alita

WORKDIR /srv/alita

EXPOSE 9000

CMD ["php-fpm"]
