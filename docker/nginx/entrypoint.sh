#!/bin/sh

# Ejecuta el script add_host_entry.sh
/usr/local/bin/add_host_entry.sh

# Inicia NGINX
nginx -g "daemon off;"
