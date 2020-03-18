#!/bin/bash

# Install NodeJS v12.x LTS on CentOS 7

# Logging
declare PREFIX="Calvin | node-js |"

yum install -y gcc-c++ make
echo "${PREFIX} Installed dependencies" >> ./calvin.log

curl -sL https://rpm.nodesource.com/setup_12.x | bash -
yum clean all
yum makecache fast
yum install -y nodejs
echo "${PREFIX} Installed NodeJS $(node -v)" >> ./calvin.log
echo "${PREFIX} Installed NPM $(npm -v)" >> ./calvin.log