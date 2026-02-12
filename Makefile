SHELL := /usr/bin/env bash
API_PORT ?= 8000


COMPOSE_FILE := infra/docker/docker-compose.yml
POSTGRES_USER ?= kb
POSTGRES_DB ?= knowledge_browser
DUMP_FILE ?= db_dump.sql

.PHONY: help bootstrap format lint test check compose-up compose-down compose-logs compose-reset smoke db-shell db-dump

help:
	@echo "Available targets:"
	@echo "  bootstrap    Create .venv and install editable dependencies"
	@echo "  format       Apply Ruff formatting and auto-fixes"
	@echo "  lint         Run Ruff checks and Mypy"
	@echo "  test         Run unit tests"
	@echo "  check        Run format + lint + test"
	@echo "  compose-up   Start local Docker Compose stack"
	@echo "  compose-down Stop local Docker Compose stack"
	@echo "  compose-logs Stream Docker Compose logs"
	@echo "  compose-reset Recreate local Docker Compose stack and volumes"
	@echo "  smoke        Run basic API smoke check"
	@echo "  db-shell     Open psql shell in local Postgres container"
	@echo "  db-dump      Dump local Postgres database to SQL file"

bootstrap:
	@infra/scripts/bootstrap.sh

format:
	@. .venv/bin/activate && \
	python -m ruff check --fix \
	  libs/kb_core/src libs/kb_core/tests \
	  services/api/src services/api/tests \
	  services/worker/src services/worker/tests
	@. .venv/bin/activate && \
	python -m ruff format \
	  libs/kb_core/src libs/kb_core/tests \
	  services/api/src services/api/tests \
	  services/worker/src services/worker/tests

lint:
	@infra/scripts/lint.sh

test:
	@infra/scripts/test.sh

check: format lint test

compose-up:
	docker compose -f $(COMPOSE_FILE) up -d --build

compose-down:
	docker compose -f $(COMPOSE_FILE) down

compose-logs:
	docker compose -f $(COMPOSE_FILE) logs -f

compose-reset:
	docker compose -f $(COMPOSE_FILE) down -v --remove-orphans
	docker compose -f $(COMPOSE_FILE) up -d --build

.PHONY: smoke
smoke: ## Run a minimal smoke test against the API
	@curl --fail --silent http://localhost:$(API_PORT)/healthz
	@echo

db-shell:
	docker compose -f $(COMPOSE_FILE) exec postgres psql -U $(POSTGRES_USER) -d $(POSTGRES_DB)

db-dump:
	docker compose -f $(COMPOSE_FILE) exec -T postgres \
	  pg_dump -U $(POSTGRES_USER) -d $(POSTGRES_DB) > $(DUMP_FILE)
	@echo "Wrote dump to $(DUMP_FILE)"


.PHONY: compose-ps
compose-ps: ## Show running services
	@docker compose -f $(COMPOSE_FILE) ps