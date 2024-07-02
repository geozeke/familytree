ARG BASE=nginx:latest

# Base image --------------------------------------------------------

FROM ${BASE} AS runtime

# Create a non-root user ('familytree'). For security, it's important to
# run containers as a non-root user.
RUN adduser --system --group --no-create-home familytree

# Copy tree data, and password configration files for nginx.
WORKDIR /usr/share/nginx/html
ADD ./data/tree .
WORKDIR /etc/nginx/conf.d
COPY default.conf .
WORKDIR /etc/nginx
COPY ./data/htpasswd .

EXPOSE 80

# Switch to the non-root user before starting the container.
USER familytree
