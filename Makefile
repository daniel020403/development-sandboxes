DOCKER_COMPOSE_DIR=.
DOCKER_COMPOSE_FILE=$(DOCKER_COMPOSE_DIR)/docker-compose.yml
DOCKER_COMPOSE=docker compose -f $(DOCKER_COMPOSE_FILE) --project-directory $(DOCKER_COMPOSE_DIR)

DEFAULT_GOAL := help
help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-27s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Development sandboxes:
##@		loopback4: A Loopback4 sandbox environment.

##@ Sandbox Build
.PHONY: build-all
build-all: ## Builds all sandbox images and start all sandbox.
	$(DOCKER_COMPOSE) rm -fs && \
	$(DOCKER_COMPOSE) build --pull --no-cache --parallel && \
	$(DOCKER_COMPOSE) up -d --force-recreate

.PHONY: build-sandbox
build-sandbox: ## Build a sandbox image and start the sandbox. Syntax: `make build-sandbox SANDBOX=<sandbox name>`.
	$(DOCKER_COMPOSE) rm -fs $(SANDBOX) && \
	$(DOCKER_COMPOSE) build --pull --no-cache --parallel $(SANDBOX) && \
	$(DOCKER_COMPOSE) up -d --force-recreate $(SANDBOX)

.PHONY: start-all
start-all: ## Starts all sandboxes.
	$(DOCKER_COMPOSE) start

.PHONY: stop-all
stop-all: ## Stops all sandboxes.
	$(DOCKER_COMPOSE) stop

.PHONY: start-sandbox
start-sandbox: ## Start a sandbox. Syntax: `make start-sandbox SANDBOX=<sandbox name>`.
	$(DOCKER_COMPOSE) start $(SANDBOX)

.PHONY: stop-sandbox
stop-sandbox: ## Stop a sandbox. Syntax: `make stop-sandbox SANDBOX=<sandbox name>`.
	$(DOCKER_COMPOSE) stop $(SANDBOX)

.PHONY: remove-all
remove-all: ## Removes all sandboxes.
	$(DOCKER_COMPOSE) down

.PHONY: remove-sandbox
remove-sandbox: ## Remove a sandbox. Syntax: `make remove-sandbox SANDBOX=<sandbox name>`.
	$(DOCKER_COMPOSE) down $(SANDBOX)
