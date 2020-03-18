#!/bin/bash

# Adds the MariaDB 10.4 repository and upgrades the existing install

cp ./resources/maria10-4.repo /etc/yum.repos.d/
yum -y upgrade maria* >> ./calvin.yum.log
systemctl restart mariadb

echo "Upgraded MariaDB to 10.4.x and restarted service" >> ./calvin.log