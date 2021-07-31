# Nick's Blog

## Setup

Install hugo if it's not already

````bash
make get-hugo
````

## Development Server

This mode will watch for changes under `site/` and continually re-build

````bash
make serve
````

## Deploy

The following environment variables can be used to modify deployment settings

- `HUGO_DEPLOY_DIR`
- `HUGO_SSH_HOST` 
- `HUGO_SSH_DIR`
- `HUGO_SSH_USER`

````bash
make deploy
````



