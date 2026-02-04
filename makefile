# =========================
# Config
# =========================
COMPOSE=docker compose
ENV_FILE=.env

# =========================
# Targets
# =========================

.PHONY: build up down restart logs ps clean

## Build images
build-ingest-data-pipeline:
	docker build -f Dockerfile -t taxi_ingest:v001 .

ingest-data:
	docker run -it --rm \
	--network pg-network \
	taxi_ingest:v001 \
	--year=$(YEAR) \
	--month=$(MONTH) \
	--pg-host=pgdatabase \

## Start services (detached)
up:
	$(COMPOSE) --env-file $(ENV_FILE) up -d

## Stop and remove containers
down:
	$(COMPOSE) --env-file $(ENV_FILE) down

## Restart services
restart: down up

## Show running containers
ps:
	$(COMPOSE) ps

## Follow logs
logs:
	$(COMPOSE) logs -f

## Stop + remove containers, networks, volumes
clean:
	$(COMPOSE) --env-file $(ENV_FILE) down -v
