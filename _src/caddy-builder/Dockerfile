FROM golang:1.10.3-alpine3.7

LABEL maintainer="Fanybook <fanybook@126.com>"

RUN echo -e "#!/bin/sh\n\nls -l --color=auto \"\$@\"" > /bin/ll \
    && chmod 777 /bin/ll

ARG CHANGE_ALPINE_SOURCE=true
RUN if [ ${CHANGE_ALPINE_SOURCE} = true ]; then \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories \
;fi

# don't del git & build-base (dep gcc .. when caddyplug install)
RUN apk update \
    && apk upgrade \
    && apk add --no-cache git \
    && apk add --no-cache build-base \
    && go get github.com/abiosoft/caddyplug/caddyplug \
    && caddyplug install-caddy \
    && caddy --version \
    && rm -rf /var/cache/apk/*
