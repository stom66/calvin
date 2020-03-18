#!/bin/bash

# Creates a default domain for the hostname in Virtualmin with the default features
# Expects $1 to be a valid FQDN
# Expects $2 to be a password for the default domain webmin

# Logging
declare PREFIX="Calvin | create-default-domain |"

virtualmin create-domain --domain "$1" --pass "$2" --default-features


# Done
echo "${PREFIX} completed" >> ./calvin.log