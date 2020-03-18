#!/bin/bash

# Adds the MariaDB 10.4 repository and upgrades the existing install

declare PREFIX="Calvin | maria-upgrade |"

cp ./resources/maria10-4.repo /etc/yum.repos.d/
yum -y upgrade maria*
systemctl restart mariadb

echo "${PREFIX} Upgraded MariaDB to $(mariadb -V)" >> ./calvin.log
echo "${PREFIX} MariaDB service restarted " >> ./calvin.log