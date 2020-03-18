#!/bin/bash

# Adds the MariaDB 10.4 repository and upgrades the existing install
# Expects $1 to be a password for MySQL root user

declare PREFIX="Calvin | maria-upgrade |"

cp ./resources/maria10-4.repo /etc/yum.repos.d/
yum -y upgrade maria*
systemctl restart mariadb

echo "${PREFIX} Upgraded MariaDB to 10.4.x and restarted service" >> ./calvin.log
mariadb -v -p"$1" >> ./calvin.log