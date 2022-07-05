ARG NGINX_VERSION

FROM nginx:$NGINX_VERSION

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y \
 build-essential \
 apt-utils \
 ca-certificates \
 apt-transport-https \
 gnupg \
 wget \
 curl \
 libcurl4-openssl-dev \
 nano \
 git \
 zip \
 iputils-ping \
 vim \
 dnsutils \
 net-tools \
 htop \
 zsh

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN chsh -s /bin/zsh

COPY nginx.conf /etc/nginx/nginx.conf
ADD sites-enabled /etc/nginx/sites-enabled
RUN rm -rf /etc/nginx/conf.d/default.conf

WORKDIR /srv/alita/public