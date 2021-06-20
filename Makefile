
BASE_DIR=$(shell pwd)
SRC_DIR=$(BASE_DIR)/site
SSH_DIR=/var/local/nicksblog/site

SSH_USER=nick
SSH_HOST=dev1

RSYNC_LOG=rsync.log

HUGO_VERSION="0.83.1"

PORT=1313
DEV_PORT=13131
STAGING_ADDR=192.168.2.7
STAGING_URL=http://192.168.2.7
SERVICE_PATH=/etc/systemd/system/nicksblog.service


help:
	@echo 'Usage:'
	@echo 'make serve [PORT=13131]    serve site and watch src for changes' 	

provision:
	apt-get update && apt-get install -y python3 python3-pip rsync
	wget https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_$(HUGO_VERSION)_Linux-64bit.deb -O /tmp/hugo_$(HUGO_VERSION).deb
	dpkg -i /tmp/hugo_$(HUGO_VERSION).deb
	if test ! -f $(SERVICE_PATH) 2>/dev/null; then cp $(BASE_DIR)/server/nicksblog.service $(SERVICE_PATH); fi
	systemctl daemon-reload && systemctl start nicksblog.service

serve:
	systemctl restart nicksblog.service

stage_serve:
	hugo server --port $(PORT) --bind=$(STAGING_ADDR) --baseURL=$(STAGING_URL) --source="$(SRC_DIR)"

dev_serve:
	hugo server --port $(DEV_PORT) --source "$(SRC_DIR)"

watch:
	hugo watch --source "$(SRC_DIR)"

deploy:
	rsync -avv --log-file=$(RSYNC_LOG) "$(SRC_DIR)/" $(SSH_HOST):$(SSH_DIR)/

.PHONY: help
