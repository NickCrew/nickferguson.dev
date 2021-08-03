# Nick's Blog

[![CI](https://github.com/NickCrew/nickferguson.dev/actions/workflows/build.yml/badge.svg)](https://github.com/NickCrew/nickferguson.dev/actions/workflows/build.yml)

Project files for [nickferguson.dev](https://nickferguson.dev).  

Hugo (extended) is required to development and build the site.

## Development

### Install Hugo

Install Hugo (extended) from tarball release.

You can modify the version by setting `HUGO_VERSION`.  
The default `HUGO_INSTALL_DIR` is `/usr/local/bin`. 

````bash
make install-hugo
````

### Local Dev Server

This mode will watch for changes under `site/` and continually re-build.

You can modify `HUGO_BASE_URL`, `HUGO_BIND_ADDR` and `HUGO_PORT` as needed.

````bash
make serve
````

## Building and Packaging

Generate the static files to be served.

### Clean (optiona)

Remove the contents of `HUGO_BUILD_OUTPUT`

````bash
make clean
````

### Build

Generates `HUGO_BUILD_OUTPUT` (default: `site/public/`).  

You can build for three environments by setting `HUGO_BUILD_ENV` (default: `production`):  
- `development` 
- `staging`
- `production`  

````bash
make build
````

### Manual Deploy

Deploy the `HUGO_BUILD_OUTPUT` to the remote host `HUGO_SSH_HOST` at the path `HUGO_DEPLOY_TARGET_DIR` (default: `/var/www/$(HUGO_SITE_NAME)`)  

Performed via rsync over SSH.  The `HUGO_SSH_CONN` defines the remote connection in the format `user(optional)@host`.  

````bash
make deploy
````

### Package Public Html

Create a zip archive of `HUGO_BUILD_OUTPUT`.

````bash
make package
````
which will produce `nickferguson.dev-public.zip`



