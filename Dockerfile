ARG BASE=nginxinc/nginx-unprivileged:latest

# Base image --------------------------------------------------------

FROM ${BASE} AS runtime

# Copy tree data, and password configration files for nginx.
WORKDIR /usr/share/nginx/html
RUN mkdir -p languages/en
ADD ./data/tree ./languages/en
WORKDIR /etc/nginx/conf.d
COPY default.conf .
WORKDIR /etc/nginx
COPY ./data/htpasswd .

EXPOSE 80
