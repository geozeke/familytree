set shell := ["bash", "-eu", "-o", "pipefail", "-c"]
image := "familytree"
tag := "latest"

# Show help
default: help

# --------------------------------------------

# setup project required directories
setup:
    #!/usr/bin/env bash
    if [ ! -f .init/setup ]; then
    	mkdir -p scratch data/tree .init
    	touch .init/setup
        cp templates/compose-template.yml compose.yml
        cp templates/Dockerfile-template Dockerfile
        cp templates/default-template.conf default.conf
        echo "Setup complete"
    else
        echo "Initial setup is already complete."
        echo
    fi

# --------------------------------------------

# remove family tree data
reset:
	@echo Removing family tree data
	rm -rf ./data/tree/*

# --------------------------------------------

# Clean out any old docker images
clean-docker:
    -docker container stop {{image}} > /dev/null 2>&1
    -docker container rm {{image}} > /dev/null 2>&1
    -docker image rm {{image}}:{{tag}}

# --------------------------------------------

# Create a docker image
image: clean-docker
    docker buildx build -t {{image}}:{{tag}} . --no-cache --pull

# --------------------------------------------

# Create docker image and preserve build artifacts
image-dev:
    docker buildx build -t {{image}}:{{tag}} .

# --------------------------------------------

# Show available recipes
help:
    @just --list
    