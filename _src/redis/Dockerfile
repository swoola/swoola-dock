FROM redis:4.0-alpine

LABEL maintainer="Fanybook <fanybook@126.com>"

RUN echo -e "#!/bin/sh\n\nls -l --color=auto \"\$@\"" > /bin/ll \
    && chmod 777 /bin/ll

ARG CHANGE_ALPINE_SOURCE=true
RUN if [ ${CHANGE_ALPINE_SOURCE} = true ]; then \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories \
;fi

EXPOSE 6379

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 775 /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["redis-server", "/etc/redis/redis.conf"]
