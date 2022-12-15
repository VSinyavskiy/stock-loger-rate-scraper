FROM php:8.1.6-fpm-alpine

WORKDIR /

RUN apk update && \
    # Supervisor
    apk add --no-cache supervisor 

RUN set -ex && \
    # Amqp
    apk add --no-cache rabbitmq-c && \
    apk add --no-cache rabbitmq-c-dev && \
    apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS && \
    pecl install -o -f amqp && \
    docker-php-ext-enable amqp && \
    docker-php-ext-install bcmath && \
    apk del .phpize-deps

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
