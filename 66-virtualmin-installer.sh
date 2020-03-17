#!/bin/bash

# fetches and triggers the latest version of the virtualmin installer
# expects $1 to be a valid FQDN

wget -O ./virtualmin-installer.sh http://software.virtualmin.com/gpl/scripts/install.sh
chmod +x ./virtualmin-installer.sh
./virtualmin-installer.sh --hostname "$1" --force