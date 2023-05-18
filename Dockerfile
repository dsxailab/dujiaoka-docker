FROM webdevops/php-nginx:7.4-alpine
LABEL maintainer="sudo@dov.moe"

ENV INSTALL=true

WORKDIR /dujiaoka

COPY dujiaoka/ /dujiaoka
COPY ./conf/default.conf /opt/docker/etc/nginx/vhost.conf
COPY ./conf/dujiao.conf /opt/docker/etc/supervisor.d/
COPY start.sh /

RUN set -xe \
    && composer install -vvv \
    && chmod +x /start.sh \
    && chown -R application:application /dujiaoka/ \
    && chmod -R 0755 /dujiaoka/ \
    && mv /dujiaoka/storage /dujiaoka/storage_bak \
    && sed -i "s?\$proxies;?\$proxies=\'\*\*\';?" /dujiaoka/app/Http/Middleware/TrustProxies.php \
    && rm -rf /root/.composer/cache/ /tmp/*
# workaround the issue that the quick search is not visible on phone
RUN sed -i 's/d-md-inline-block/d-sm-inline-block d-block/' ./vendor/dcat/laravel-admin/resources/views/grid/quick-search.blade.php

CMD /start.sh
