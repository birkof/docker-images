FROM php:7-fpm

MAINTAINER Daniel STANCU <birkof@birkof.ro>

ENV APP_DIR=/var/www/html \
    COMPOSER_CACHE_DIR=/var/cache/composer \
    COMPOSER_ALLOW_SUPERUSER=1

ENV PATH=${APP_DIR}/bin:${APP_DIR}/vendor/bin:${PATH}

RUN requirements="libmcrypt-dev libicu-dev libmcrypt4 libicu52 libsqlite3-dev libxml2-dev libjpeg62-turbo-dev libcurl4-gnutls-dev libbz2-dev libssl-dev libmemcached-dev unzip libpcre3-dev" \
    requirementsToRemove="libmcrypt-dev g++ libicu-dev zlib1g-dev" \
    && apt-get update && apt-get install -yq --no-install-recommends apt-utils git vim openssh-client $requirements \
    && docker-php-ext-install   intl \
                                mbstring \
                                pdo_mysql \
                                mcrypt \
                                json \
                                zip \
                                pdo_mysql \
                                pdo_sqlite \
                                opcache \
                                calendar \
                                bcmath \
                                xml \
                                xmlrpc \
                                bz2 \
                                mcrypt \
                                curl \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    # Redis
    && git clone -b php7 https://github.com/phpredis/phpredis.git /etc/phpredis \
    && cd /etc/phpredis/ \
    && phpize \
    && ./configure \
    && make && make install \
    && docker-php-ext-enable redis \
    # Memcached
    && git clone -b php7 https://github.com/php-memcached-dev/php-memcached /tmp/php-memcached \
    && cd /tmp/php-memcached/ \
    && phpize \
    && ./configure --with-php-config=/usr/local/bin/php-config \
    && make && make install \
    && docker-php-ext-enable memcached \
    # Memcache
    && cd /tmp \
    && curl -sSL -o php7.zip https://github.com/websupport-sk/pecl-memcache/archive/php7.zip \
    && unzip php7 \
    && cd pecl-memcache-php7 \
    && /usr/local/bin/phpize \
    && ./configure --with-php-config=/usr/local/bin/php-config \
    && make \
    && make install \
    && docker-php-ext-enable memcache \
    && rm -rf /tmp/pecl-memcache-php7 php7.zip \
    && apt-get purge --auto-remove -y $requirementsToRemove

# Install composer
RUN curl -LsS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer --version \
    && composer global require hirak/prestissimo

# get PHP CodeSniffer (https://pear.php.net/package/PHP_CodeSniffer)
RUN curl -LsS https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar -o /usr/local/bin/phpcs \
    && chmod a+x /usr/local/bin/phpcs \
    && phpcs --version

# php-cs-fixer
RUN curl http://get.sensiolabs.org/php-cs-fixer.phar -o php-cs-fixer \
    && chmod a+x php-cs-fixer \
    && mv php-cs-fixer /usr/local/bin/php-cs-fixer

# Install phpunit
RUN curl -LsS https://phar.phpunit.de/phpunit.phar -o /usr/local/bin/phpunit \
    && chmod a+x /usr/local/bin/phpunit \
    && phpunit --version

# Install Symfony Installer
RUN curl -LsS http://symfony.com/installer -o /usr/local/bin/symfony \
    && chmod a+x /usr/local/bin/symfony \
    && symfony --version

# Symfony console shortcuts
RUN echo '#!/bin/bash' > /usr/local/bin/dev && echo 'php -dmemory_limit=-1 ${APP_DIR}/bin/console --env=dev $@' >> /usr/local/bin/dev && chmod +x /usr/local/bin/dev \
    && echo '#!/bin/bash' > /usr/local/bin/prod && echo 'php ${APP_DIR}/bin/console --env=prod $@' >> /usr/local/bin/prod && chmod +x /usr/local/bin/prod

# Clean up the mess
RUN apt-get autoclean \
    && apt-get clean \
    && rm -rf /etc/phpredis \
    && rm -rf /tmp/php-memcached \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Ensure www-data has access to file from volume if file are mapped as uid/gid 1000/1000
RUN usermod -u 1000 www-data && \
    groupmod -g 1000 www-data

# Injecting assets
ADD .docker /

# Injecting container bootstrap file
RUN mv /bootstrap.sh /usr/local/bin/bootstrap \
    && chmod +x /usr/local/bin/bootstrap

# Working dir
WORKDIR ${APP_DIR}

# Exposed port
EXPOSE 9000

ENTRYPOINT ["bootstrap"]
CMD ["php-fpm", "-F"]