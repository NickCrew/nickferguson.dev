
BASE_DIR=$(shell pwd)
SRC_DIR=$(BASE_DIR)/site
HUGO_CONFIG=$(SRC_DIR)/config.toml

SSH_DIR=/var/local/nicksblog/site
SSH_USER=nick
SSH_HOST=dev1


LOCAL_INSTALL_PATH=$(BASE_DIR)
HUGO_VERSION ?= "0.84.1"
RELEASE_TARBALL_URL="https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_$(HUGO_VERSION)_Linux-64bit.tar.gz"

PORT ?= 1313

BIND_ADDR ?= 0.0.0.0

BASE_URL ?= http://192.168.2.7

HUGO_BIN ?= $(LOCAL_INSTALL_PATH)/bin/hugo

POST_TYPE ?= post
POST_EXTEN ?= md

help:
	@echo 'Usage:'
	@echo 'make serve serve site and watch src for changes' 	

install-hugo:
	curl -fsSL $(RELEASE_TARBALL_URL) > /tmp/hugo.tar.gz
	mkdir -p $(LOCAL_INSTALL_PATH)/share/hugo
	mkdir -p $(LOCAL_INSTALL_PATH)/bin
	tar -xvf /tmp/hugo.tar.gz -C $(LOCAL_INSTALL_PATH)/share/hugo
	ln -s $(LOCAL_INSTALL_PATH)/share/hugo/hugo $(HUGO_BIN)

build:
	$(HUGO_BIN) --source $(SRC_DIR)

dev-srv:
	$(HUGO_BIN) server --source $(SRC_DIR) --port $(PORT) --bind=$(BIND_ADDR) --baseURL=$(BASE_URL) --disableFastRender --buildDrafts

watch:
	hugo watch --source "$(SRC_DIR)"

deploy:
	rsync -avh "$(SRC_DIR)/" $(SSH_HOST):$(SSH_DIR)/ --delete --log-file=$(RSYNC_LOG) 

new:
	hugo --source "$(SRC_DIR)" new $(POST_TYPE)/$(POST_NAME).$(POST_EXTEN)

.PHONY: help
