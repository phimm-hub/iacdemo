#get base nginx RP base image

FROM nginx:stable-alpine

RUN apk add openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/cert.key -out /etc/nginx/cert.crt -subj "/C=US/ST=NY/L=NY/O=Phimm/OU=Phimm/CN=local host"

RUN apk add apache2-utils

RUN htpasswd -c -b /etc/nginx/htpasswd admin Password1
