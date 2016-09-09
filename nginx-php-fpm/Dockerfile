FROM alpine:3.4

MAINTAINER birkof <docker@birkof.ro>

ENV TERM=xterm
ENV TZ=Europe/London
ENV SHELL=/bin/zsh

# Install packages
RUN echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
    && echo http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
    && apk update \
    && apk add --no-cache \
        bash \
        zsh \
        tzdata \
        wget \
        curl \
        vim \
        git \
        openssh-client \
        supervisor \
        nginx \
        php7-fpm \
        php7-pdo \
        php7-pdo_mysql \
        php7-mysqlnd \
        php7-mysqli \
        php7-mcrypt \
        php7-ctype \
        php7-zlib \
        php7-gd \
        php7-intl \
        php7-sqlite3 \
        php7-pdo_pgsql \
        php7-pgsql \
        php7-xml \
        php7-xsl \
        php7-curl \
        php7-openssl \
        php7-iconv \
        php7-json \
        php7-phar \
        php7-dom \
        php7-zip \
        php7-session \
        php7-xdebug  \
        python \
        python-dev \
        py-pip \
        augeas-dev \
        openssl-dev \
        ca-certificates \
        dialog \
        gcc \
        musl-dev \
        linux-headers \
        libffi-dev \
    && apk del \ 
        gcc \
        musl-dev \
        linux-headers \ 
        libffi-dev \
        augeas-dev \ 
        python-dev \
    && rm -rf /var/cache/apk/* \
    && find / -type f -iname \*.apk-new -delete


# Small fixes
RUN ln -s /etc/php7 /etc/php \
    && ln -s /usr/bin/php7 /usr/bin/php \
    && ln -s /usr/lib/php7 /usr/lib/php

# Install composer
RUN curl -LsS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer --version

# Install PhpUnit
RUN curl -LsS https://phar.phpunit.de/phpunit.phar -o /usr/local/bin/phpunit \
    && chmod a+x /usr/local/bin/phpunit \
    && phpunit --version

# Installing “Oh My ZSH!”
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Necesary resources
RUN mkdir -p /etc/nginx/sites-enabled /etc/nginx/ssl /var/log/supervisor /run/nginx \
    && rm -Rf /var/www/* \
    && mkdir -p /var/www/html
    
# Nginx default vhost file    
RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf


# Injecting s assets files
ADD .docker /

# Injecting container bootstrap file
RUN mv /bootstrap.sh /usr/local/bin/bootstrap \
    && chmod +x /usr/local/bin/bootstrap

# Working dir
WORKDIR /var/www/html

# Volume mounting
VOLUME /var/www/html

# Exposed ports
EXPOSE 443 80

CMD ["bootstrap"]