#!/bin/bash

# Installs the aws-cli utility
# Optionally $1 & $2 can be an AWS-CLI access key and secret key

# Logging
declare PREFIX="Calvin | aws-cli |"

if ! type "$aws-cli" > /dev/null; then
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install
	echo "${PREFIX} Installed aws-cli $(aws --version)" >> ./calvin.log
else
	echo "${PREFIX} aws-cli is already installed: $(aws --version)" >> ./calvin.log	
fi

# add aws-cli credentials if provided
if [[ ! -z "$1" && ! -z "$2" ]]; then
	[ ! -d /home/centos/.aws ] && mkdir /home/centos/.aws
	if [ ! -f /home/centos/.aws/credentials ]; then
		touch /home/centos/.aws/credentials 
		chown centos:centos /home/centos/.aws/credentials
		echo "[default]" >> ~/.aws/credentials
		echo "aws_access_key_id=${1}" >> ~/.aws/credentials
		echo "aws_secret_access_key=${2}" >> ~/.aws/credentials
		echo "${PREFIX} Installed aws-cli $(aws --version)" >> ./calvin.log
	fi
fi
