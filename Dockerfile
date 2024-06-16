ARG BASE=nginx:latest

# Base image --------------------------------------------------------

FROM ${BASE} AS runtime

# Copy tree data, and password configration files for nginx.
WORKDIR /usr/share/nginx/html
COPY data/tree/* .
WORKDIR /etc/nginx/conf.d
COPY default.conf .
WORKDIR /etc/nginx
COPY ./data/htpasswd .

EXPOSE 80
