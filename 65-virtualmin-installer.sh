#!/bin/bash

# Fetches and triggers the latest version of the virtualmin installer
# Expects $1 to be a valid FQDN
# Expects $2 to be a valid user to enable the virtualmin admin panel for
# Expects $3 to be a password for the virtualmin admin panel

# Logging
declare PREFIX="Calvin | virtualmin-installer |"

curl -o ./virtualmin-installer.sh http://software.virtualmin.com/gpl/scripts/install.sh
echo "${PREFIX} curled latest installer" >> ./calvin.log

chmod +x ./virtualmin-installer.sh
./virtualmin-installer.sh --hostname "$1" --force
echo "${PREFIX} completed install with hostname $1" >> ./calvin.log

if [[ ! -z "$2" && ! -z "$3" ]]; then
	sudo /usr/libexec/webmin/changepass.pl /etc/webmin "$2" "$3"
	echo "${PREFIX} password updated for Virtualmin user $2" >> ./calvin.log
fi