#!/bin/bash

# Updates Virtualmin virtual server default features and plugins

# Logging
declare PREFIX="Calvin | virtualmin-features |"
echo "Configuring Virtualmin features (this can take a while)..."

# Enable SSL by default
virtualmin set-global-feature --default-on ssl
echo "${PREFIX} SSL enabled" >> ./calvin.log

# Disable AWstats by default
virtualmin set-global-feature --default-off virtualmin-awstats 
echo "${PREFIX} AWStats disabled" >> ./calvin.log

# Disable DAV by default
virtualmin set-global-feature --default-off virtualmin-dav 
echo "${PREFIX} DAV disabled" >> ./calvin.log

# Change autoconfig script to have hard-coded STARTTLS
virtualmin modify-mail --all-domains --autoconfig
sudo virtualmin modify-template --id 0 --setting autoconfig --value "$(cat ./resources/autoconfig.xml | tr '\n' ' ')"
sudo virtualmin modify-template --id 0 --setting autodiscover --value "$(cat ./resources/autodiscover.xml | tr '\n' ' ')"
echo "${PREFIX} autoconfig enabled and STARTTLS hard-coded" >> ./calvin.log