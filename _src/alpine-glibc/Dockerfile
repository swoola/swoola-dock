FROM alpine:3.8

LABEL maintainer="Fanybook <fanybook@126.com>"

RUN echo -e "#!/bin/sh\n\nls -l --color=auto \"\$@\"" > /bin/ll \
    && chmod 777 /bin/ll

ARG CHANGE_ALPINE_SOURCE=true
RUN if [ ${CHANGE_ALPINE_SOURCE} = true ]; then \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories \
;fi

RUN apk update \
    && apk upgrade \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.27-r0/glibc-2.27-r0.apk \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.27-r0/glibc-bin-2.27-r0.apk \
    && apk add glibc-2.27-r0.apk --allow-untrusted \
    && apk add glibc-bin-2.27-r0.apk  --allow-untrusted \
    && rm -f glibc-2.27-r0.apk \
    && rm -f glibc-bin-2.27-r0.apk \
    && rm -rf /var/cache/apk/*
