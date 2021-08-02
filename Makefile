
TMPDIR ?= /tmp
BASE_DIR=$(shell pwd)
HUGO_SRC_DIR ?= $(BASE_DIR)/site
HUGO_CONFIG ?= $(HUGO_SRC_DIR)/config.toml
HUGO_THEMES_DIR ?= $(HUGO_SRC_DIR)/themes
HUGO_CONTENT_DIR ?= $(HUGO_SRC)/content
HUGO_LAYOUT_DIR ?= $(HUGO_SRC)/layouts
HUGO_HTML_DIR ?= $(HUGO_SRC_DIR)/public


HUGO_ENVIRONMENT ?= development
HUGO_STAGING_PATH ?= /var/www/html
HUGO_BUILD_OUTPUT ?= $(HUGO_HTML_DIR)

HUGO_THEME ?= noteworthy
HUGO_VERSION ?= "0.86.1"
HUGO_PORT ?= 1313
HUGO_BIND_ADDR ?= 0.0.0.0
HUGO_BASE_URL ?= 192.168.2.7

HUGO_SITE_NAME ?= nickferguson.dev
HUGO_DEPLOY_TARGET_DIR ?= /var/www/$(HUGO_SITE_NAME)
HUGO_SSH_USER ?= root
HUGO_SSH_HOST ?= dev1

RELEASE_TARBALL_URL="https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_$(HUGO_VERSION)_Linux-64bit.tar.gz"

HUGO_BIN ?= hugo

POST_TYPE ?= post
POST_EXTEN ?= md

help:
	@echo 'USAGE:'
	@echo 'make serve                 : serve site and watch src for changes' 	
	@echo 'make build                 : build the site. default output site/public'
	@echo 'make deploy                : upload the site to the server defined here'
	@echo "make new [POST_NAME=foo]   : create a new post named 'foo' in file 'post/foo.md" 

clean:
	rm -rf $(HUGO_HTML_DIR)/* 2>/dev/null

stage:
	sudo rsync -avh site/public/ /var/www/html/

serve:
	$(HUGO_BIN) server --bind=$(HUGO_BIND_ADDR) --source site --baseURL=$(HUGO_BASE_URL) --appendPort=false --port=$(HUGO_PORT) --disableFastRender

build:
	$(HUGO_BIN) --source $(HUGO_SRC_DIR) \
		--environment $(HUGO_ENVIRONMENT) \
		--cleanDestinationDir
archive:
	zip public.html $(HUGO_HTML_DIR)

deploy:
	rsync -avh \
		"$(HUGO_BUILD_OUTPUT)/" \
		$(HUGO_SSH_USER)@$(HUGO_SSH_HOST):$(HUGO_DEPLOY_TARGET_DIR)/ \
		--delete \
		--log-file=rsync.log

install-hugo:
	curl -fsSL $(RELEASE_TARBALL_URL) > hugo.tar.gz
	tar --extract --file=hugo.tar.gz $(HUGO_BIN)
	rm hugo.tar.gz

watch:
	$(HUGO_BIN) watch --source "$(HUGO_SRC_DIR)"

new-single-post:
	$(HUGO_BIN) --source "$(HUGO_SRC_DIR)" \
		new $(POST_TYPE)/$(POST_NAME).$(POST_EXTEN)

new-page-bundle:
	mkdir -p $(HUGO_CONTENT_DIR)/post/$(POST_NAME)
	$(HUGO_BIN) --source "$(HUGO_SRC_DIR)" \
		new post/$(POST_NAME)/index.md \
		--editor vim
