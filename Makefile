
BASEDIR=$(CURDIR)
SRCDIR=$(BASEDIR)/site


PORT ?= 13131



help:
	@echo 'Usage:'
	@echo 'make serve [PORT=13131]    serve site and watch src for changes' 	

serve:
	hugo serve -p $(PORT) -s "$(SRCDIR)"

watch:
	hugo watch -s "$(SRCDIR)"

provision:
	apt-get update && apt-get install -y python3 python3-pip
	pip3 install hugo


.PHONY: help
