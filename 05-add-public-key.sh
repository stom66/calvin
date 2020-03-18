#!/bin/bash

# Add public key to user centos authorized_keys
# Expects $1 to be a valid public key

if [ ! -z "$1" ]; then
	mkdir /home/centos/.ssh
	chmod 700 /home/centos/.ssh 
	touch /home/centos/.ssh/authorized_keys
	chmod 600 /home/centos/.ssh/authorized_keys
	echo "$1" >> /home/centos/.ssh/authorized_keys
	chown -R centos:centos /home/centos/.ssh
else
	echo "There was a problem adding the public key to authorized_keys" >> ./calvin.log
fi