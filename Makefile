


NAME         := mw
TAG          := mw
NET          := $(shell cat .env | grep DOCKER_NETWORK | sed 's/.*=//')
DB_PASSWORD  := $(shell cat .env | grep DB_PASSWORD | sed 's/.*=//')
ADMINER_PORT := $(shell cat .env | grep ADMINER_LOCALHOST_PORT | sed 's/.*=//')

NET_EXISTS    = $(shell docker network ls | grep ${NET} | wc -l | sed 's/ *//g')

TSTAMP        = $(shell date "+%Y%m%d_%H%M%S")

# ------------------------------------------------------------------------------

.PHONEY: list
check:
	@echo "         NET |${NET}|"
	@echo " DB_PASSWORD |${DB_PASSWORD}|"
	@echo "ADMINER_PORT |${ADMINER_PORT}|"
	@echo "      TSTAMP |${TSTAMP}|"
	docker ps

.PHONEY: list
list: check-net

.PHONEY: dps
dps:
	docker ps | grep ${TAG} | grep -v grep


# ------------------------------------------------------------------------------

.PHONEY: create-net
create-net:
	@if [ $(NET_EXISTS) -eq 1 ] ; then \
		echo "Docker network - ${NET} - exists already"; \
	else \
		echo "Creating new docker network - ${NET}"; \
		docker network create ${NET}; \
	fi

.PHONEY: check-net
check-net:
	-docker network ls  | grep ${NET}

# ------------------------------------------------------------------------------

reset:
	-rm -rf data/db-mysql/*

data:
	mkdir -p data \
		data/db-mysql \
		data/db-root \
		data/db-bak \
		data/mw-images \
		data/mw-root \
		data/mw-bak

setup: create-net
	docker compose -f docker-compose-setup.yml up -d
	docker ps
	
run:
	docker run --name mediawiki -p 8080:80 -d mediawiki
	docker ps

up:
	docker compose up -d
	docker ps | grep mw | grep -v grep


down:
	docker compose down


bash-db:
	docker exec -it mw-database bash

backup-db:
	docker exec -t mw-database mariadb-dump -u root -p${DB_PASSWORD} --all-databases > data/db-bak/${TSTAMP}.sql
	ls -l data/db-bak

bash-mw:
	docker exec -it mw-mediawiki bash

backup-mw:
	docker exec -it mw-mediawiki /root/bin/backup.sh


