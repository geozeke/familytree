ARG BASE=nginxinc/nginx-unprivileged:latest

# Base image
FROM ${BASE} AS runtime

# Switch to root, set correct permissions on htpasswd, then switch back
# to nginx (unprivileged user)
USER root
COPY ./data/htpasswd /etc/nginx/htpasswd
RUN chown nginx:nginx /etc/nginx/htpasswd && chmod 644 /etc/nginx/htpasswd
USER nginx

# Copy website and configurationfiles
COPY ./data/tree/ /usr/share/nginx/html/
COPY default.conf /etc/nginx/conf.d/

EXPOSE 80