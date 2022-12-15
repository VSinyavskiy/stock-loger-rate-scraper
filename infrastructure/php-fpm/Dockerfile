FROM php:8.1.6-fpm-alpine

WORKDIR /var/www/html

RUN set -ex && \
    # Composer
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    # Postgres
    apk add --no-cache postgresql-dev && \
    docker-php-ext-install pdo pdo_pgsql && \
    # Amqp
    apk add --no-cache rabbitmq-c && \
    apk add --no-cache rabbitmq-c-dev && \
    apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS && \
    pecl install -o -f amqp && \
    docker-php-ext-enable amqp && \
    docker-php-ext-install bcmath && \
    apk del .phpize-deps
