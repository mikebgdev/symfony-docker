#!/bin/sh

server_owner="$SERVER_OWNER"
projects_json="$PROJECTS_JSON"
projects=$(echo "$projects_json" | jq '.[]')

container_ip=$(ip -4 addr show eth0 | awk '$1 == "inet" {print $2}' | awk -F/ '{print $1}')

for project in $(echo "$projects" | jq -c '.[]'); do
    name=$(echo "$project" | jq -r '.name')
    host=$(echo "$project" | jq -r '.host')

    if ! grep -q "$host" /etc/hosts; then
        echo "$container_ip $host" >>/etc/hosts
        
        openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout "/etc/nginx/certificates/$name.key.pem" -out "/etc/nginx/certificates/$name.crt.pem" -subj \
            "/C=AT/ST=$server_owner/L=$server_owner/O=Security/OU=Development/CN=$host"

        /usr/local/bin/nginx_conf.sh "$host" "$name"
    fi
done
