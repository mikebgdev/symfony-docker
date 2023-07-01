#!/bin/sh

# Get the host name from the environment variable
CONTAINER_IP=$(ip -4 addr show eth0 | awk '$1 == "inet" {print $2}' | awk -F/ '{print $1}')

# Check if the host entry already exists in /etc/hosts
if ! grep -q "$SERVER_NAME" /etc/hosts; then
    # Add the host entry to /etc/hosts
    echo "$CONTAINER_IP $SERVER_NAME" >> /etc/hosts
    echo "Added the host entry '$SERVER_NAME' to /etc/hosts."
fi
