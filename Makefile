
BASEDIR=$(shell pwd)
SRC_DIR=$(BASEDIR)/site
SSH_DIR=/var/local/nicksblog/site
SSH_HOST=dev1
HUGO_VERSION="0.83.1"

PORT=1313
DEV_PORT=13131
STAGING_ADDR=192.168.2.7
STAGING_URL=http://192.168.2.7

RSYNC_LOG=rsync.log

help:
	@echo 'Usage:'
	@echo 'make serve [PORT=13131]    serve site and watch src for changes' 	

install_hugo:
	wget https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_$(HUGO_VERSION)_Linux-64bit.deb -O /tmp/hugo_$(HUGO_VERSION).deb
	dpkg -i /tmp/hugo_$(HUGO_VERSION).deb

serve:
	systemctl restart nicksblog.service

stage_serve:
	hugo server --port $(PORT) --bind=$(STAGING_ADDR) --baseURL=$(STAGING_URL) --source="$(SRC_DIR)"

dev_serve:
	hugo server --port $(DEV_PORT) --source "$(SRC_DIR)"

watch:
	hugo watch --source "$(SRC_DIR)"

provision:
	apt-get update && apt-get install -y python3 python3-pip
	pip3 install hugo

deploy:
	rsync -avv --log-file=$(RSYNC_LOG) "$(SRC_DIR)/" $(SSH_HOST):$(SSH_DIR)/

dry_run_deploy:
	rsync -avv --dry-run --log-file=$(RSYNC_LOG) "$(SRC_DIR)/" $(SSH_HOST):$(SSH_DIR)/


.PHONY: help
