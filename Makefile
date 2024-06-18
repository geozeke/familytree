IMAGE=tree
TAG=latest

# --------------------------------------------

all: help

# --------------------------------------------

.PHONY: setup
setup: ## setup project with runtime dependencies
ifeq (,$(wildcard .init/setup))
	if [ ! -d "./scratch" ]; then \
		mkdir -p scratch; \
	fi
	if [ ! -d "./data" ]; then \
		mkdir -p data/tree; \
	fi
	mkdir .init
	touch .init/setup
else
	@echo "Initial setup is already complete. If you are having issues, run:"
	@echo
	@echo "make reset"
	@echo "make setup"
	@echo
endif

# --------------------------------------------

.PHONY: reset
reset: ## remove family tree data
	@echo Removing family tree data
	rm -rf ./data/tree/*

# --------------------------------------------

# Some of these may fail (hence the leading '-'), but if the build is in some
# indeterminate state, this target attempts to cleanup anything that could be
# laying around.
.PHONY: clean-docker
clean-docker: ## remove docker container and image
	-docker container stop ${IMAGE}
	-docker container rm ${IMAGE}
	-docker image rm ${IMAGE}:${TAG}
	docker image prune -f

# --------------------------------------------

.PHONY: image
image: clean-docker ## create a standalone docker image for the project
	docker buildx build -t ${IMAGE}:${TAG} --no-cache .

# --------------------------------------------

.PHONY: image-dev
image-dev: ## create docker image and preserve build artifacts
	docker buildx build -t ${IMAGE}:${TAG} .

# --------------------------------------------

.PHONY: help
help: ## show help
	@echo Please specify a target. Choices are:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk \
	'BEGIN {FS = ":.*?## "}; \
	{printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
