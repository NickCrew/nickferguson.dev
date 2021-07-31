FROM nginx:latest

EXPOSE 80
EXPOSE 443

WORKDIR /usr/share/nginx/html

COPY site/public/ .

