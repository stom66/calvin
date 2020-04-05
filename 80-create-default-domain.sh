#!/bin/bash

# Creates a default domain for the hostname in Virtualmin with the default features
# Expects $1 to be a valid FQDN
# Expects $2 to be a password for the default domain webmin

# Logging
declare PREFIX="Calvin | create-default-domain |"
declare DOMAIN="$1"

virtualmin create-domain --domain "$1" --pass "$2" --default-features

declare HOME_DIR=$(virtualmin list-domains | grep "${DOMAIN}" | awk -F" " '{print $2}')

if [ ! -z "$HOME_DIR" ]; then
	# Copy default server status page
	cp ./resources/index.html "/home/${HOME_DIR}/public_html/index.html"
	echo "${PREFIX} Created /home/${HOME_DIR}/public_html/index.html" >> ./calvin.log
	
	sed -i -e "s/example\.com/${DOMAIN}/g" "/home/${HOME_DIR}/public_html/index.html"
fi

# Done
echo "${PREFIX} completed" >> ./calvin.log