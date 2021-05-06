
BASEDIR=$(shell pwd)
SRCDIR=$(BASEDIR)/site
HUGO_VERSION="0.83.1"

PORT=1313
DEV_PORT=13131
STAGING_ADDR=192.168.2.7
STAGING_URL=http://192.168.2.7

help:
	@echo 'Usage:'
	@echo 'make serve [PORT=13131]    serve site and watch src for changes' 	

install_hugo:
	wget https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_$(HUGO_VERSION)_Linux-64bit.deb -O /tmp/hugo_$(HUGO_VERSION).deb
	dpkg -i /tmp/hugo_$(HUGO_VERSION).deb

serve:
	hugo server --source "$(SRCDIR)"

stage_serve:
	hugo server --port $(PORT) --bind=$(STAGING_ADDR) --baseURL=$(STAGING_URL) --source="$(SRCDIR)"

dev_serve:
	hugo server --port $(DEV_PORT) --source "$(SRCDIR)"

watch:
	hugo watch --source "$(SRCDIR)"

provision:
	apt-get update && apt-get install -y python3 python3-pip
	pip3 install hugo


.PHONY: help
