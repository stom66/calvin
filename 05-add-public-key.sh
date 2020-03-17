#!/bin/bash
# add public key to authorized_keys
# expects $1 to be a valid public key

if [! -z "$1" ]; then
	mkdir /home/centos/.ssh
	chmod 700 /home/centos/.ssh 
	touch /home/centos/.ssh/authorized_keys
	chmod 600 /home/centos/.ssh/authorized_keys
	echo "$1" >> /home/centos/.ssh/authorized_keys
	chown -R centos:centos /home/centos/.ssh
fi