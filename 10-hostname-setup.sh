#!/bin/bash

# Apply Network and hostname settings
# Expects $1 to be an FQDN
declare PREFIX="Calvin | hostname-setup |"

hostnamectl set-hostname --static "$1"
echo "prepend domain-name-servers 127.0.0.1;" | sudo tee -a /etc/dhcp/dhclient.conf
echo "preserve_hostname: true" | sudo tee -a /etc/cloud/cloud.cfg
systemctl restart network

echo "${PREFIX} Configured system to use hostname: ${DOMAIN}" >> ./calvin.log