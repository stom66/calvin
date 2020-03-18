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

# Done
echo "${PREFIX} completed" >> ./calvin.log