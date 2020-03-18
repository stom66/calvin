#!/bin/bash

# Fetches and triggers the latest version of the virtualmin installer
# Expects $1 to be a valid FQDN
# Expects $2 to be a valid user to enable the virtualmin admin panel for
# Expects $3 to be a password for the virtualmin admin panel

curl -o ./virtualmin-installer.sh http://software.virtualmin.com/gpl/scripts/install.sh
chmod +x ./virtualmin-installer.sh
./virtualmin-installer.sh --hostname "$1" --force


if [[ ! -z "$2" && ! -z "$3" ]]; then
	sudo /usr/libexec/webmin/changepass.pl /etc/webmin "$2" "$3"
	echo "Enabled Virtualmin admin panel for user $2 with password: $3" >> ./calvin.log
fi