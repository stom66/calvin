#!/bin/bash

# Install NodeJS v12.x LTS on CentOS 7

yum install -y gcc-c++ make >> ./calvin.yum.log
curl -sL https://rpm.nodesource.com/setup_12.x | bash -
yum clean all  >> ./calvin.yum.log
yum makecache fast >> ./calvin.yum.log
yum install -y nodejs >> ./calvin.yum.log