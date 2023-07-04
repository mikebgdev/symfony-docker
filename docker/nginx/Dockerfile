FROM nginx:1.25-alpine

# set main params
ARG SERVER_OWNER=""
ENV SERVER_OWNER=$SERVER_OWNER
ARG PROJECTS_JSON=""
ENV PROJECTS_JSON=$PROJECTS_JSON

RUN apk update && \
    apk add --no-cache jq 

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    rm -rf /etc/nginx/conf.d/*

# Copy the add_host_entry.sh script to the container
COPY nginx/scripts/create_hosts.sh /usr/local/bin/
COPY nginx/scripts/entrypoint.sh /usr/local/bin/
COPY nginx/scripts/nginx_conf.sh /usr/local/bin/

# Make the script executable
RUN chmod +x /usr/local/bin/create_hosts.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/nginx_conf.sh

# install openssl
RUN apk add --update openssl && \
    rm -rf /var/cache/apk/*

# create folder for certificates
RUN mkdir -p /etc/nginx/certificates
RUN chmod +x /etc/nginx/certificates
