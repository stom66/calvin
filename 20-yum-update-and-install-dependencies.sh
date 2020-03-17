#!/bin/bash
# runs yum update and installs various dependencies

PACKAGES=""
PACKAGES="{$PACKAGES} screen wget nano epel-release gcc gcc-c++ gem git"
PACKAGES="{$PACKAGES} lm_sensors make ncdu perl perl-Authen-PAM"
PACKAGES="{$PACKAGES} perl-CPAN ruby-devel rubygems scl-utils util-linux"
PACKAGES="{$PACKAGES} yum-utils zip"

yum update -y
yum install -y $PACKAGES 

echo "Installed and updated yum packages" >> ./setup-script.log