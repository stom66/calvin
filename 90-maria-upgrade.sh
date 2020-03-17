#!/bin/bash

# Adds the MariaDB 10.4 repository and upgrades the existing install
cp ./maria10-4.repo /etc/yum.repos.d/
yum -y upgrade maria*
systemctl restart mariadb