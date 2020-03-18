#!/bin/bash

# Installs the aws-cli utility

# Logging
declare PREFIX="Calvin | aws-cli |"

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

echo "${PREFIX} Installed aws-cli $(aws --version)" >> ./calvin.log

# Add credentials if provided

# touch ~/.aws/credentials
# echo "[default]" >> ~/.aws/credentials
# echo "aws_access_key_id=AKIAIOSFODNN7EXAMPLE" >> ~/.aws/credentials
# echo "aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY" >> ~/.aws/credentials
