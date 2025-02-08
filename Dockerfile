ARG BASE=nginxinc/nginx-unprivileged:latest

# Base image --------------------------------------------------------

FROM ${BASE} AS runtime

# Copy tree data, and password configration files for nginx.
WORKDIR /usr/share/nginx/html
USER root
RUN mkdir -p languages/en
USER nginx
COPY ./data/tree/ /usr/share/nginx/html/languages/en/
WORKDIR /etc/nginx/conf.d
COPY default.conf .
WORKDIR /etc/nginx
COPY ./data/htpasswd .

EXPOSE 80
