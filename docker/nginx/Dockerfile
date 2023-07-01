FROM nginx:1.25-alpine

# set main params
ARG SERVER_OWNER=""
ENV SERVER_OWNER=$SERVER_OWNER
ARG SERVER_NAME=""
ENV SERVER_NAME=$SERVER_NAME

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    rm -rf /etc/nginx/conf.d/*

# Copy the add_host_entry.sh script to the container
COPY nginx/add_host_entry.sh /usr/local/bin/add_host_entry.sh

# Make the script executable
RUN chmod +x /usr/local/bin/add_host_entry.sh

# install openssl
RUN apk add --update openssl && \
    rm -rf /var/cache/apk/*

# create folder for certificates
RUN mkdir -p /etc/nginx/certificates
RUN chmod +x /etc/nginx/certificates

# generate certificates
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/certificates/key.pem -out /etc/nginx/certificates/cert.pem -subj \
    "/C=AT/ST=$SERVER_OWNER/L=$SERVER_OWNER/O=Security/OU=Development/CN=$SERVER_NAME"

# put nginx config
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Copia el script de inicio personalizado
COPY nginx/entrypoint.sh /usr/local/bin/

# Convierte el script de inicio en ejecutable
RUN chmod +x /usr/local/bin/entrypoint.sh