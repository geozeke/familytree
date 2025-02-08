ARG BASE=nginxinc/nginx-unprivileged:latest

# Base image
FROM ${BASE} AS runtime

# Switch to root to set permissions
USER root

# Set correct permissions on htpasswd
COPY ./data/htpasswd /etc/nginx/htpasswd
RUN chown nginx:nginx /etc/nginx/htpasswd && chmod 644 /etc/nginx/htpasswd
# Ensure proper directory structure
# RUN mkdir -p /usr/share/nginx/html/languages/en

# Switch back to the unprivileged nginx user
USER nginx

# Copy website files
# COPY ./data/tree/ /usr/share/nginx/html/languages/en/
COPY ./data/tree/ /usr/share/nginx/html/

# Copy Nginx configuration
COPY default.conf /etc/nginx/conf.d/

EXPOSE 80