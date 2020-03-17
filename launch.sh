#!/bin/bash

# Parse provided parameters
while [ $# -gt 0 ]; do
	key="$1"
	case $key in
		-h|--help)
			echo "CentOS Amazon LightSail Virtualmin Installer (CALVIn)"
			echo " "
			echo "This script will configure a CentOS 7 Amazon Lightsail instance to provide"
			echo "a typical webhosting framework. It will install the following major features and "
			echo "their required dependencies"
			echo "	* Virtualmin - apache, mysql, postfix, dovecot, etc"
			echo "	* NodeJS 12.x "
			echo "	* PHP 7.2 (via Virtualmin) and 7.4 (via Remi) "
			echo "	* Install a supplied public key "
			echo "	* Add a custom MotD with system overview "
			echo "	* Tweak various config options "

			echo "options:"
			echo "-h, --help                show brief help"
			echo "-d, --domain domain.tld   specify an FQDN to use as the system hostname"
			echo "-k, --pubkey PUBKEY      specify an public key to be added to the authorized_keys file"
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
		-p|--password)
			PUBKEY="$2"
			shift
			shift
			;;
		*)
			break
			;;
	esac
done


printf "|| Starting CALVIn. Checking config \n"
printf "|| ================================ \n"

# Check we have a domain to use for configuration, prompt if not
if [ -z "$DOMAIN" ]; then
	printf "Enter a valid FQDN (example.com):"
	read -e -p "Enter Your Name:" -i "Ricardo" NAME
	read -r DOMAIN
fi

# Quit out if the user failed to provide a FQDN
if [ -z "$DOMAIN" ]; then
	printf "You must specify a FQDN. Script is exiting.\n\n"
	exit 0
fi

# Check if we're using a pubkey, or request one
if [ -z "$PUBKEY" ]; then
	printf "Enter an optional public key to install (skip):"
	read -r PUBKEY
fi

# Check we have a password to use for the Virtualmin admin
if [ -z "$PASSWORD" ]; then
	PASSWORD = date +%s | sha256sum | base64 | head -c 32
	read -e -p "a password for the Virtualmin admin panel: " -i "${PASSWORD}" PASSWORD
fi


# Print the vars we're using
print_vars() {
	printf "|| FQDN:          ${DOMAIN} \n"
	printf "|| Public key:    ${PUBKEY} \n"
	printf "|| \n"
}
printf "$(print_vars)"


# Start install log
touch ./calvin.log
TIME_START=$(date +"%T")
echo "Install started at: $TIME_START" >> ./calvin.log
echo "   Using FQDN:      $DOMAIN" >> ./calvin.log
echo "   Using pubkey:    $PUBKEY" >> ./calvin.log

# Add pubkey
if [ -z "$PUBKEY" ]; then
	echo "Skipping pubkey (none provided)" >> ./calvin.log
else
	sudo sh 05-add-public-key.sh -k "${PUBKEY}"
	echo "Added pubkey to authorized_keys: ${PUBKEY}" >> ./calvin.log
fi

# Configure hostname and network
sudo sh 10-hostname-setup.sh "${DOMAIN}"
echo "Configured system to use hostname: ${DOMAIN}" >> ./calvin.log

# Trigger yum updates and dependecy installs
sudo sh 20-yum-update-and-install-dependencies.sh
echo "Yum installed and updated" >> ./calvin.log

# Add SysInfo MOTD
sudo sh 40-add-motd-system-info.sh
echo "Added sysinfo motd" >> ./calvin.log

# Add Remi PHP 7.4
sudo sh 50-php-add-remi.sh
echo "Installed Remi PHP 7.4:" >> ./calvin.log
php -v >> ./calvin.log

# Add Node 12.x
sudo sh 55-node-js-12.sh
echo "Installed NodeJS 12.x:" >> ./calvin.log
node -v >> calvin.log

# Add virtualmin
sudo sh 66-virtualmin-installer.sh "${DOMAIN}"