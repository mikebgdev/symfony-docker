#!/bin/sh

/usr/local/bin/create_hosts.sh

nginx -g "daemon off;"
systemctl restart nginx