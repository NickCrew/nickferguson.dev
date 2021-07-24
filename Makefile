
BASE_DIR=$(shell pwd)
SRC_DIR=$(BASE_DIR)/site

SSH_DIR=/var/local/nicksblog/site
SSH_USER=nick
SSH_HOST=dev1


HUGO_VERSION ?= "0.84.1"
RELEASE_TARBALL_URL="https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_$(HUGO_VERSION)_Linux-64bit.tar.gz"

PORT ?= 1313

BIND_ADDR ?= 0.0.0.0

BASE_URL ?= http://192.168.2.7

HUGO_BIN ?= $(BASE_DIR)/bin/hugo

help:
	@echo 'Usage:'
	@echo 'make serve serve site and watch src for changes' 	

dev-setup:
	curl -fsSL $(RELEASE_TARBALL_URL) > /tmp/hugo.tar.gz
	mkdir -p ./bin
	tar -xvf /tmp/hugo.tar.gz -C ./bin

build:
	$(HUGO_BIN) --source $(SRC_DIR)

serve:
	$(HUGO_BIN) server --source $(SRC_DIR) --port $(PORT) --bind=$(BIND_ADDR) --baseURL=$(BASE_URL) --disableFastRender

watch:
	hugo watch --source "$(SRC_DIR)"

deploy:
	rsync -avh "$(SRC_DIR)/" $(SSH_HOST):$(SSH_DIR)/ --delete --log-file=$(RSYNC_LOG) 

.PHONY: help
