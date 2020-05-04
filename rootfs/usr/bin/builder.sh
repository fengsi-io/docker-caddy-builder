#!/bin/sh
set -e;

for plugin in $(echo $CADDY_PLUGINS | tr "," " "); do
    plugin=$(echo $plugin | sed -E 's/(.*)@.*/\1/')
    sed -i "/import/a\\\t_ \"${plugin}\"" main.go
done

go get -v github.com/abiosoft/parent
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.io,direct
go mod init caddy

# caddy version
go mod edit -require github.com/caddyserver/caddy@v$CADDY_VERSION
for plugin in $(echo $CADDY_PLUGINS | tr ',' ' '); do
    if echo $plugin | grep -q '@'; then
        go mod edit -require $plugin
    fi
done
go install
