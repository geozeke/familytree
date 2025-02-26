IMAGE=familytree
TAG=latest

# --------------------------------------------

all: help

# --------------------------------------------

.PHONY: setup
setup: ## setup project required directories
ifeq (,$(wildcard .init/setup))
	mkdir -p scratch data/tree .init
	touch .init/setup
else
	@echo "Initial setup is already complete.
	@echo
endif

# --------------------------------------------

.PHONY: reset
reset: ## remove family tree data
	@echo Removing family tree data
	rm -rf ./data/tree/*

# --------------------------------------------

# Some of these may fail (hence the leading '-'), but if the build is in
# some indeterminate state, this target attempts to cleanup anything
# that could be laying around.
.PHONY: clean-docker
clean-docker: ## remove docker container and image
	-docker container stop ${IMAGE} > /dev/null 2>&1
	-docker container rm ${IMAGE} > /dev/null 2>&1
	-docker image rm ${IMAGE}:${TAG}

# --------------------------------------------

.PHONY: image
image: clean-docker ## create a docker image for the family tree
	docker buildx build -t ${IMAGE}:${TAG} --no-cache --pull .

# --------------------------------------------

.PHONY: image-dev
image-dev: ## create a docker image but preserve build artifacts
	docker buildx build -t ${IMAGE}:${TAG} .

# --------------------------------------------

.PHONY: help
help: ## show help
	@echo ""
	@echo "🚀 Available Commands 🚀"
	@echo "========================"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk \
	'BEGIN {FS = ":.*?## "}; \
	{printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
