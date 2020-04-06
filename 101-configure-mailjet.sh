#!/bin/bash
# Configure MailJet Relay
# Expects $1 to be the domain we're enabling email for

if [ ! -z "$1" ]; then
	# Configure MailJet Relay
	postconf -e 'relayhost = in.mailjet.com'
	postconf -e 'smtp_sasl_auth_enable = yes'
	postconf -e 'smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd'
	postconf -e 'smtp_sasl_security_options = noanonymous'
	
	echo "@${1} in.mailjet.com" | sudo tee /etc/postfix/sasl_passwd

	echo "Set Postfix to use MailJet relay" >> ./calvin.log
else
	echo "No domain provided for MailJet relay" >> ./calvin.log
fi