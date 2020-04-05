#!/bin/bash

# Installs the aws-cli utility
# Optionally $1 & $2 can be an AWS-CLI access key and secret key

# Logging
declare PREFIX="Calvin | aws-cli |"

# Fetch and install AWS CLI v2
if [ ! -f /usr/local/bin/aws ]; then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip -o -q awscliv2.zip
    rm awscliv2.zip
    sudo ./aws/install
    rm -rf ./aws
    echo "${PREFIX} Installed aws-cli $(/usr/local/bin/aws --version)" >> ./calvin.log
fi

# add aws-cli credentials if provided
if [[ ! -z "$1" && ! -z "$2" ]]; then
    declare INSTANCE_REGION
    declare INSTANCE_ID
    declare INSTANCE_NAME
    declare PROTOCOL

    #generate credntials file
	[ ! -d ~/.aws ] && mkdir ~/.aws # make dir if not exist
	if [ ! -f ~/.aws/credentials ]; then
		touch ~/.aws/credentials 
		echo "[default]" >> ~/.aws/credentials
		echo "aws_access_key_id=${1}" >> ~/.aws/credentials
		echo "aws_secret_access_key=${2}" >> ~/.aws/credentials
	fi
    
    # get info on this instance
    INSTANCE_REGION=$(/usr/local/bin/aws configure list | grep region | awk '{print $2}')
    INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
    INSTANCE_NAME=$(/usr/local/bin/aws lightsail get-instances --query "instances[?contains(supportCode,'`curl -s http://169.254.169.254/latest/meta-data/instance-id`')].name" --output text)
    echo "${PREFIX} Configured to control instance ${INSTANCE_NAME} ${INSTANCE_ID} running on ${INSTANCE_REGION}" >> ./calvin.log

    # generate config file
	if [ ! -f ~/.aws/config ]; then
		touch ~/.aws/config         
        echo "[default]" >> ~/.aws/config
        echo "region=${INSTANCE_REGION}" >> ~/.aws/config
        echo "output=text" >> ~/.aws/config
    fi

    # Open Ports
    PORTS=(22 25 80 443 465 587 995 10000)
    echo "${PREFIX} Opening ports ${PORTS[@]}" >> ./calvin.log
    PROTOCOL="tcp"

    for PORT in ${PORTS[@]}; do
        # using "both" seems to cause a bug that removes all ports. fix this later.
        
        # if [ "$PORT" -gt "1000" ]; then
        #     PROTOCOL="tcp"
        # else
        #     PROTOCOL="both"
        # fi

        /usr/local/bin/aws lightsail open-instance-public-ports --cli-input-json "{
            \"portInfo\": {
                \"fromPort\": ${PORT},
                \"toPort\": ${PORT},
                \"protocol\": \"${PROTOCOL}\"
            },
            \"instanceName\": \"${INSTANCE_NAME}\"
        }" | grep '"status": "Succeeded"' &> /dev/null
        if [ $? != 0 ]; then
            echo "${PREFIX} Failed to open port ${PORT}" >> ./calvin.log
        fi
    done
else
    echo "${PREFIX} No CLI credentials provided. Unable to configure aws-cli or open ports" >> ./calvin.log
fi

