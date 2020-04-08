#!/bin/bash

# Creates a default domain for the hostname in Virtualmin with the default features
# Expects $1 to be a valid FQDN
# Expects $2 to be a password for the default domain webmin

# Logging
declare PREFIX="Calvin | create-default-domain |"
declare DOMAIN="$1"

# Create a virtual site for the default domain
virtualmin create-domain --domain "$1" --pass "$2" --default-features

declare HOME_DIR=$(virtualmin list-domains | grep "${DOMAIN}" | awk -F" " '{print $2}')

if [ ! -z "$HOME_DIR" ]; then
	# Copy default server status page
	cp ./resources/index.html "/home/${HOME_DIR}/public_html/index.html"
	echo "${PREFIX} Created /home/${HOME_DIR}/public_html/index.html" >> ./calvin.log
	
	# Update status page with correct domain
	sed -i -e "s/example\.com/${DOMAIN}/g" "/home/${HOME_DIR}/public_html/index.html"
fi

# Generate and install lets encrypt certificate
virtualmin generate-letsencrypt-cert --domain "$1" >> calvin.ssl.log

virtualmin install-service-cert --domain "$1" --service postfix >> calvin.ssl.log
virtualmin install-service-cert --domain "$1" --service usermin >> calvin.ssl.log
virtualmin install-service-cert --domain "$1" --service webmin >> calvin.ssl.log
virtualmin install-service-cert --domain "$1" --service dovecot >> calvin.ssl.log
virtualmin install-service-cert --domain "$1" --service proftpd >> calvin.ssl.log

echo "${PREFIX} LetsEncrypt certificate requested and copied to services (see calvin.ssl.log for more info)" >> ./calvin.log