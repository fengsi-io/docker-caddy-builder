FROM golang:1-alpine

WORKDIR /caddy

RUN set -ex; \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories; \
    apk add --no-cache git

COPY ./rootfs/ /

ARG GOOS=linux
ARG GOARCH=amd64
ARG CADDY_VERSION=1.0.l5
ARG CADDY_PLUGINS

CMD ["/bin/sh", "/usr/bin/builder.sh"]
