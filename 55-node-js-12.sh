#!/bin/bash

# Install NodeJS v12.x LTS on CentOS 7

yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_12.x | bash -
yum clean all && yum makecache fast
yum install -y nodejs