IMAGE ?= docker-caddy-builder
REGISTRY ?= registry.us-west-1.aliyuncs.com/fengsi
TAGS += dev-latest

.ONESHELL:
build:
	@proxy=http://$$(powershell "(Get-NetIPAddress -PrefixOrigin Dhcp -AddressState Preferred -AddressFamily IPv4).IPAddress"):1080
	@command="docker build --pull --force-rm  -t $(IMAGE)"
	@for tag in $(TAGS); do
		command="$$command -t $(REGISTRY)/$(IMAGE):$$tag"
	done
	@eval "$$command ."

.ONESHELL:
push: build
	@for tag in $(TAGS); do
		docker push $(REGISTRY)/$(IMAGE):$$tag
	done

.ONESHELL:
test: build
	@docker run \
		--rm \
		-v $$(pwd)/bin:/go/bin \
		-e "CADDY_PLUGINS=\
			github.com/epicagency/caddy-expires\
			github.com/captncraig/caddy-realip \
			" \
		$(IMAGE)
	@echo
	@docker run -it --rm -v $$(pwd)/bin:/go/bin $(IMAGE) caddy -version
	@echo "--------------------------"
	@docker run -it --rm -v $$(pwd)/bin:/go/bin $(IMAGE) caddy -plugins
