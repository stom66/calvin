#!/bin/bash

# Runs YUM update and installs various dependencies

PACKAGES=""
PACKAGES="{$PACKAGES} screen wget nano epel-release gcc gcc-c++ gem git"
PACKAGES="{$PACKAGES} lm_sensors make ncdu perl perl-Authen-PAM"
PACKAGES="{$PACKAGES} perl-CPAN ruby-devel rubygems scl-utils util-linux"
PACKAGES="{$PACKAGES} yum-utils zip"

yum update -y >> ./calvin.yum.log
yum install -y $PACKAGES >> ./calvin.yum.log

echo "Installed and updated yum packages (see calvin.yum.log for more detail)" >> ./calvin.log