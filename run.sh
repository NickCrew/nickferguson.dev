#!/usr/bin/env bash

set -e

alias hugo=$PWD/bin/hugo

hugo server \
	--source=$PWD/site \
	--baseUrl=https://nickferguson.dev \
	--port=1313 
	--appendPort=false
