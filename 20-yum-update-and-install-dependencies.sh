#!/bin/bash

# Runs YUM update and installs various dependencies

# Logging
declare PREFIX="Calvin | yum-update |"

# Yum update
yum update -y
echo "${PREFIX} Updated existing packages" >> ./calvin.log

PACKAGES=""
PACKAGES="${PACKAGES} screen wget nano epel-release gcc gcc-c++ gem git"
PACKAGES="${PACKAGES} lm_sensors make ncdu perl perl-Authen-PAM"
PACKAGES="${PACKAGES} perl-CPAN ruby-devel rubygems scl-utils util-linux"
PACKAGES="${PACKAGES} yum-utils zip unzip"

yum install -y $PACKAGES
echo "${PREFIX} Installed the following yum packages:" >> ./calvin.log
echo "${PREFIX} ${PACKAGES}" >> ./calvin.log