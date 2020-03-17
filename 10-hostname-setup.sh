#!/bin/bash
# Apply Network and hostname settings
# Expects $1 to be an fqdn

hostnamectl set-hostname --static "$1"
echo "prepend domain-name-servers 127.0.0.1;" | sudo tee -a /etc/dhcp/dhclient.conf
systemctl restart network