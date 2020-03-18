#!/bin/bash

# This script is designed to be copy-pasted over SSH and give you a simple way to 
# clone the various scripts and trigger the installer

sudo yum install git -y -q
git clone https://github.com/stom66/calvin/ calvin && cd calvin && chmod +x launch.sh
sudo ./launch.sh --domain example.com --user root --pubkey "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEflkUUVLscb4jtD23/WQe0qMwE0cEVvtoO5A8dUz8l7"