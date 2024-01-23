FROM php:8.2-fpm-alpine

# Main params
ARG SYMFONY_VERSION=""
ENV SYMFONY_VERSION ${SYMFONY_VERSION}
ARG PROJECTS_JSON=""
ENV PROJECTS_JSON=$PROJECTS_JSON

WORKDIR /var/www/

# php extensions installer: https://github.com/mlocati/docker-php-extension-installer
COPY --from=mlocati/php-extension-installer:latest --link /usr/bin/install-php-extensions /usr/local/bin/

RUN apk add --no-cache \
		acl \
		fcgi \
		file \
		gettext \
		git \
	;

RUN set -eux; \
    install-php-extensions \
		apcu \
		intl \
		opcache \
		zip \
    ;

RUN apk update && \
    apk add --no-cache jq

RUN apk add libpng-dev libjpeg-turbo-dev freetype-dev
RUN apk update
RUN docker-php-ext-install gd

# Install nodejs npm
RUN apk update && apk add --no-cache \
    nodejs \
    npm

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY --link docker/php/conf.d/app.ini $PHP_INI_DIR/conf.d/

COPY --link docker/php/php-fpm.d/www.conf /usr/local/etc/php-fpm.d/www.conf
RUN mkdir -p /var/run/php

COPY --link docker/php/docker-healthcheck.sh /usr/local/bin/docker-healthcheck
RUN chmod +x /usr/local/bin/docker-healthcheck

HEALTHCHECK --interval=10s --timeout=3s --retries=3 CMD ["docker-healthcheck"]

COPY --link docker/php/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENTRYPOINT ["docker-entrypoint"]
CMD ["php-fpm"]

# Install php-cs-fixer
RUN wget https://cs.symfony.com/download/php-cs-fixer-v3.phar -O /usr/local/bin/php-cs-fixer && \
    chmod +x /usr/local/bin/php-cs-fixer

# Install phpstan
RUN wget https://github.com/phpstan/phpstan/releases/download/1.0.0/phpstan.phar -O /usr/local/bin/phpstan && \
    chmod +x /usr/local/bin/phpstan

# Install phpunit
RUN wget https://phar.phpunit.de/phpunit-9.phar -O /usr/local/bin/phpunit && \
    chmod +x /usr/local/bin/phpunit

# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV PATH="${PATH}:/root/.composer/vendor/bin"

COPY --from=composer/composer:2-bin --link /composer /usr/bin/composer
