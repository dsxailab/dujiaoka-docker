FROM webdevops/php-nginx:7.4

ENV INSTALL=true

WORKDIR /app

COPY dujiaoka/ /app

RUN [ "sh", "-c", "composer install --ignore-platform-reqs" ]
COPY ./start.sh /app/start.sh
RUN [ "sh", "-c", "chmod -R 777 /app" ]
CMD [ "sh", "-c","/app/start.sh" ]

