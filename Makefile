# 
# Build nickferguson.dev hugo site
#

HUGO_SITE_NAME ?= nickferguson.dev

HUGO_THEME ?= noteworthy
HUGO_VERSION ?= 0.86.1

TMPDIR ?= /tmp
HUGO_BASE_DIR=$(shell pwd)
HUGO_SRC_DIR ?= $(HUGO_BASE_DIR)/site
HUGO_CONFIG_DIR ?= $(HUGO_SRC_DIR)/config
HUGO_THEMES_DIR ?= $(HUGO_SRC_DIR)/themes
HUGO_CONTENT_DIR ?= $(HUGO_SRC_DIR)/content
HUGO_LAYOUT_DIR ?= $(HUGO_SRC_DIR)/layouts
HUGO_HTML_DIR ?= $(HUGO_SRC_DIR)/public

HUGO_BUILD_ENV ?= production
HUGO_BUILD_OUTPUT ?= $(HUGO_HTML_DIR)
HUGO_PACKAGE_OUTPUT ?= nickferguson.dev-public.zip
HUGO_INSTALL_DIR ?= /usr/local/bin
HUGO_RELEASE_TARBALL_URL="https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_$(HUGO_VERSION)_Linux-64bit.tar.gz"

HUGO_PORT ?= 13131
HUGO_BIND_ADDR ?= 127.0.0.1
HUGO_BASE_URL ?= //localhost:$(HUGO_PORT)
HUGO_APPEND_PORT ?= true

HUGO_SSH_TARGET_DIR ?= /var/www/$(HUGO_SITE_NAME)
HUGO_SSH_USER ?= root
HUGO_SSH_HOST ?= dev1
HUGO_SSH_CONN ?= $(HUGO_SSH_USER)@$(HUGO_SSH_HOST)

POST_TYPE ?= posts
POST_EXTEN ?= md

help:
	@echo 'USAGE:'
	@echo 'make serve                 : serve site and watch src for changes' 	
	@echo 'make build                 : build the site. default output site/public'
	@echo 'make deploy                : upload the site to the server defined here'
	@echo "make new [POST_NAME=foo]   : create a new post named 'foo' in file 'post/foo.md" 

clean:
	rm -rf $(HUGO_HTML_DIR)/* 2>/dev/null

watch:
	hugo watch --source "$(HUGO_SRC_DIR)"


serve:
	hugo server --source site \
		--port=$(HUGO_PORT) \
		--baseURL=$(HUGO_BASE_URL) \
		--bind=$(HUGO_BIND_ADDR) \
		--appendPort=$(HUGO_APPEND_PORT) \
		--disableFastRender

build:
	/usr/local/bin/hugo --source $(HUGO_SRC_DIR) \
		--environment $(HUGO_BUILD_ENV) \
		--cleanDestinationDir

package:
	zip $(HUGO_PACKAGE_OUTPUT) $(HUGO_BUILD_OUTPUT)

deploy:
	rsync -avh \
		"$(HUGO_BUILD_OUTPUT)/" \
		$(HUGO_SSH_CONN):$(HUGO_SSH_TARGET_DIR)/ \
		--delete \
		--log-file=rsync.log

install-hugo:
	curl -fsSL \
		$(HUGO_RELEASE_TARBALL_URL) > hugo.tar.gz
	tar --extract --file=hugo.tar.gz hugo 
	mv hugo /usr/local/bin/hugo
	rm hugo.tar.gz

new-single-post:
	hugo --source "$(HUGO_SRC_DIR)" \
		new $(POST_TYPE)/$(POST_NAME).$(POST_EXTEN)

new-page-bundle:
	mkdir -p $(HUGO_CONTENT_DIR)/post/$(POST_NAME)
	hugo --source "$(HUGO_SRC_DIR)" \
		new post/$(POST_NAME)/index.md \
		--editor vim
