FROM golang:1-alpine

WORKDIR /caddy

RUN apk add --no-cache git

COPY ./rootfs/ /

ARG GOOS=linux
ARG GOARCH=amd64
ARG CADDY_VERSION=1.0.l5
ARG CADDY_PLUGINS="\
    github.com/epicagency/caddy-expires \
    github.com/captncraig/caddy-realip \
    "

CMD ["/bin/sh", "/usr/bin/builder.sh"]
