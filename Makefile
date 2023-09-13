SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:

MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

install:  ## Install dependences
	poetry install
.PHONY: install

test:  ## Run check and test
	poetry run python manage.py check
	poetry run pytest
.PHONY: test

lint:  ## Check lint
	poetry run ruff check --diff .
	poetry run black --check --diff .
.PHONY: lint

lint-fix:  ## Fix lint
	poetry run ruff check --fix .
	poetry run black .
.PHONY: lint-fix

typecheck:  ## Run typechecking
	poetry run pyright .
.PHONY: typecheck

ci: lint typecheck test  ## Run all checks (lint, typecheck, test)
.PHONY: ci

clean:  ## Clean cache files
	find . -name '__pycache__' -type d | xargs rm -rvf
	find . -name '.pytest_cache' -type d | xargs rm -rvf
	poetry run ruff clean
.PHONY: clean

build:  ## Build Docker image
	echo "Build."
.PHONY: build

dev-server: install  ## Run local develop server
	poetry run python manage.py runserver_plus --print-sql
.PHONY: dev-server

secret-key:  ## Generate secret key
	@openssl rand -hex 32
.PHONY: secret-key

dev-services-up:  ## Start servers for local dev
	@docker compose -f .devcontainer/docker-compose.yml up -d
.PHONY: dev-services-up

dev-services-down:  ## Stop servers for local dev
	@docker compose -f .devcontainer/docker-compose.yml down
.PHONY: dev-services-down

dev-services-with:  ## Run docker compose with args
	docker compose -f .devcontainer/docker-compose.yml $(args)
.PHONY: dev-services-with

.DEFAULT_GOAL := help
help: Makefile
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
.PHONY: help
