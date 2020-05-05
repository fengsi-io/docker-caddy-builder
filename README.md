# Docker Caddy Builder

Builder for caddy for free commercial use.

## Useage

```shell
docker run \
    --rm \
    -v $$(pwd)/bin:/go/bin \
    -e "CADDY_VERSION=1.0.5" \
    -e "CADDY_PLUGINS=\
        github.com/epicagency/caddy-expires@v1.1.1\
        github.com/captncraig/caddy-realip \
        " \
    fengsiio/caddy-builder:latest
```
