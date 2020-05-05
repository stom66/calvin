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
virtualmin modify-template --id 0 --setting autoconfig --value '<?xml version="1.0" encoding="UTF-8"?><clientConfig version="1.1"><emailProvider id="$SMTP_DOMAIN"> <domain>$SMTP_DOMAIN</domain><displayName>$OWNER Email</displayName> <displayShortName>$OWNER</displayShortName> <incomingServer type="imap"> <hostname>$IMAP_HOST</hostname> <port>$IMAP_PORT</port> <socketType>$IMAP_TYPE</socketType> <authentication>$IMAP_ENC</authentication> <username>$SMTP_LOGIN</username></incomingServer> <incomingServer type="pop3"> <hostname>$IMAP_HOST</hostname> <port>$POP3_PORT</port> <socketType>$IMAP_TYPE</socketType> <authentication>$POP3_ENC</authentication> <username>$SMTP_LOGIN</username></incomingServer> <outgoingServer type="smtp"><hostname>$SMTP_HOST</hostname><port>$SMTP_PORT</port> <socketType>STARTTLS</socketType> <authentication>$SMTP_ENC</authentication> <username>$SMTP_LOGIN</username> </outgoingServer></emailProvider></clientConfig>'
virtualmin modify-mail --all-domains --autoconfig
echo "${PREFIX} autoconfig enabled and STARTTLS hard-coded" >> ./calvin.log