# Nick's Blog

## Install Hugo

Install Hugo (extended) from tarball release.

You can modify the version by setting `HUGO_VERSION` and you can modify the install path/binary path with `HUGO_BIN` (default is simply `hugo` of the project root. The directory must exist.).

````bash
HUGO_BIN=~/bin/hugo make install-hugo
````

## Development Server

This mode will watch for changes under `site/` and continually re-build.

You can modify `HUGO_BASE_URL`, `HUGO_BIND_ADDR` and `HUGO_PORT` as needed.

````bash
make serve
````

## Clean

Remove the contents of `HUGO_BUILD_OUTPUT`

````bash
make clean
````

## Build

This will produce the `public/` directory with HTML+CSS ready for static deployment. You can build for three environments by setting `HUGO_ENVIRONMENT`: `development`, `staging`, and `production`.  

The default `HUGO_BUILD_OUTPUT` path is `site/public/`.

````bash
HUGO_ENVIRONMENT=production make build
````

## Deploy

Deploy the `HUGO_BUILD_OUTPUT` to the remote host `HUGO_SSH_HOST` at the path `HUGO_DEPLOY_TARGET_DIR` (default: `/var/www/$(HUGO_SITE_NAME)`)

````bash
make deploy
````

## Create Zip Archive of Build Output

If you wish to create a zip archive of `HUGO_BUILD_OUTPUT`

````bash
make archive
````



