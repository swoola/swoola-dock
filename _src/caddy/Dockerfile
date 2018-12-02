FROM registry.cn-beijing.aliyuncs.com/fanybook/caddy-builder AS builder

# ARG plugins="git"
# RUN caddyplug install ${plugins}

FROM alpine:3.7

LABEL maintainer="Fanybook <fanybook@126.com>"

RUN echo -e "#!/bin/sh\n\nls -l --color=auto \"\$@\"" > /bin/ll \
    && chmod 777 /bin/ll

ARG CHANGE_ALPINE_SOURCE=true
RUN if [ ${CHANGE_ALPINE_SOURCE} = true ]; then \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories \
;fi

RUN apk update \
    && apk upgrade \
    && apk add --no-cache ca-certificates \
    && rm -rf /var/cache/apk/*

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

EXPOSE 80 443 2015

WORKDIR /var/www

CMD ["caddy", "-conf", "/etc/caddy/Caddyfile", "-agree"]
