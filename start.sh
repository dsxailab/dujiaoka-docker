#!/bin/sh

if [ -f "/app/.env" ]; then
    if [ "$INSTALL" != "true" ]; then
        echo "ok" > install.lock
    fi

    bash /app/start-hook.sh
    php artisan queue:work >/tmp/work.log 2>&1 &
    supervisord
else
    echo "配置文件不存在，请根据文档修改配置文件！"
fi
