#!/bin/bash
# Configure MailJet Relay
# Expects $1 to be the domain we're enabling email for
# Expects $2 to be the api key
# Expects $3 to be the secret key

if [ ! -z "$1" ]; then
	#Backup postfix main.cf
	postconf | sudo tee /root/postfix.main.cf.$(date "+%F-%T")

	# Configure MailJet Relay
	postconf -e 'relayhost = in-v3.mailjet.com'
	postconf -e 'smtp_sasl_auth_enable = yes'
	postconf -e 'smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd'
	postconf -e 'smtp_sasl_security_options = noanonymous'
	
	# Add credentials
	echo "in-v3.mailjet.com $2:$3" | sudo tee -a /etc/postfix/sasl_passwd
	chown root:root /etc/postfix/sasl_passwd
	chmod 600 /etc/postfix/sasl_passwd

	# # Add valid relays
	# echo "@${1} in.mailjet.com" | sudo tee /etc/postfix/sender_relay

	# Update and restart Postfix
	postmap /etc/postfix/sasl_passwd
	chmod 0600 /etc/postfix/sasl_passwd.db
	
	postfix reload
	systemctl restart postfix

	echo "Set Postfix to use MailJet relay" >> ./calvin.log
else
	echo "No domain provided for MailJet relay" >> ./calvin.log
fi