#!/bin/bash

# Setup vars
declare -l DOMAIN
declare PUBKEY
declare VMIN_USER
declare VMIN_PASSWORD
declare MYSQL_PASSWORD
declare WEBMIN_PASSWORD

# Parse provided parameters
while [ $# -gt 0 ]; do
	key="$1"
	case $key in
		-h|--help)
			echo "CentOS Amazon LightSail Virtualmin Installer (CALVIn)"
			echo " "
			echo "More information is available at https://github.com/stom67/calvin"
			echo " "
			echo "Options:"
			echo "  -h, --help                              show brief help"
			echo "  -d, --domain [domain.tld]               specify an FQDN to use as the system hostname"
			echo "  -k, --pubkey [valid pubkey]             specify an public key to be added to the authorized_keys file"
			echo "  -u, --virtualmin-user [root]            specify a user to enable the Vitualmin admin panel password for"
			echo "  -p, --virtualmin-password [mypassword]  specify a password to use for the Virtualmin admin panel"
			echo "  -m, --mysql-password [mypassword]       specify a password to use for the MySQL root user"
			echo "  -w, --webmin-password [mypassword]      specify a password to use for the default domain user"
			exit 0
			;;
		-d|--domain)
			DOMAIN="$2"
			shift
			shift
			;;
		-k|--pubkey)
			PUBKEY="$2"
			shift
			shift
			;;
		-u|--virtualmin-user)
			VMIN_USER="$2"
			shift
			shift
			;;
		-p|--virtualmin-password)
			VMIN_PASSWORD="$2"
			shift
			shift
			;;
		-m|--mysql-password)
			MYSQL_PASSWORD="$2"
			shift
			shift
			;;
		-w|--webmin-password)
			WEBMIN_PASSWORD="$2"
			shift
			shift
			;;
		*)
			break
			;;
	esac
done


printf "\n|| Starting CALVIn. Checking config \n"
printf "|| ================================ \n"

# Check we have a domain to use for configuration, prompt if not
if [ -z "$DOMAIN" ]; then
	read -e -p "|| Enter a valid FQDN: " -i "example.com" DOMAIN
fi

# Quit out if the user failed to provide a FQDN
if [ -z "$DOMAIN" ]; then
	printf "|| You must specify a FQDN. Script is exiting.\n\n"
	exit 0
fi

# Check if we're using a pubkey, or request one
if [ -z "$PUBKEY" ]; then
	read -e -p "|| Enter an optional public key to install: " -i "${PUBKEY}" PUBKEY
fi

# Check we have a user to set the password for
if [ -z "$VMIN_USER" ]; then
	read -e -p "|| Enter a valid user to grant access to the Virtualmin admin panel: " -i "root" VMIN_USER
fi

# Check we have a password to use for the Virtualmin admin
if [ -z "$VMIN_PASSWORD" ]; then
	VMIN_PASSWORD=$(date +%s|sha256sum|base64|head -c 32)
	read -e -p "|| Enter a password for the Virtualmin admin panel: " -i "${VMIN_PASSWORD}" VMIN_PASSWORD
fi

# Check we have a password to set for the MySQL root user
if [ -z "$MYSQL_PASSWORD" ]; then
	MYSQL_PASSWORD=$(date +%s|sha256sum|sha256sum|base64|head -c 32)
	read -e -p "|| Enter a password for the MySQL root user: " -i "${MYSQL_PASSWORD}" MYSQL_PASSWORD
fi

# Check we have a password to use for the default domain webmin admin
if [ -z "$WEBMIN_PASSWORD" ]; then
	WEBMIN_PASSWORD=$(date +%s|sha256sum|sha256sum|base64|head -c 32)
	read -e -p "|| Enter a password for the default domain Webmin user: " -i "${WEBMIN_PASSWORD}" WEBMIN_PASSWORD
fi

# Start install log
touch ./calvin.log
TIME_START=$(date +"%T")
echo "Install started at: $TIME_START" >> ./calvin.log
echo "   Using FQDN:      $DOMAIN" >> ./calvin.log
echo "   Using pubkey:    $PUBKEY" >> ./calvin.log

# Add pubkey
if [ -z "$PUBKEY" ]; then
	echo "Calvin | add-public-key | Skipping pubkey (none provided)" >> ./calvin.log
else
	sudo sh 05-add-public-key.sh -k "${PUBKEY}"
fi

# Configure hostname and network
sudo sh 10-hostname-setup.sh "${DOMAIN}"

# Trigger yum updates and dependecy installs
sudo sh 20-yum-update-and-install-dependencies.sh

# Add aws-cli
sudo sh 22-aws-cli.sh

# Add SysInfo MOTD
sudo sh 40-add-motd-system-info.sh

# Add Remi PHP 7.4
sudo sh 50-php-add-remi.sh

# Add Node 12.x
sudo sh 55-node-js-12.sh

# Add NPM Packages
sudo sh 60-npm-install-less-sass.sh


# Add virtualmin
if [[ ! -z $VMIN_USER && ! -z $VMIN_PASSWORD ]]; then
	sudo sh 65-virtualmin-installer.sh "${DOMAIN}" "${VMIN_USER}" "${VMIN_PASSWORD}"
else
	sudo sh 65-virtualmin-installer.sh "${DOMAIN}"
fi

# Run the Virtualmin Post-Install Wizard
sudo sh 70-virtualmin-post-install-wizard-settings.sh "${MYSQL_PASSWORD}"

# Run the Virtualmin Post-Install Wizard
sudo sh 75-virtualmin-features.sh

# Create a virtual site for the default domain
sudo sh 80-create-default-domain.sh "${DOMAIN}" "${WEBMIN_PASSWORD}"

# Upgrade MariaDB to 10.4
sudo sh 85-php-ini-tweaks.sh

# Upgrade MariaDB to 10.4
sudo sh 90-maria-upgrade.sh "${MYSQL_PASSWORD}"


printf "\n"
printf "|| CALVIn has completed \n"
printf "|| ========================================================\n"
printf "|| FQDN:                           ${DOMAIN} \n"
printf "|| Public key:                     ${PUBKEY} \n"
printf "|| MySQL root password:            ${MYSQL_PASSWORD} \n"
printf "|| Webmin default domain password: ${WEBMIN_PASSWORD} \n"
printf "|| Virtualmin user:                ${VMIN_USER} \n"
printf "|| Virtualmin password:            ${VMIN_PASSWORD} \n"
printf "|| Virtualmin panel:               https://${DOMAIN}:10000 \n"

