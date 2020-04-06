#!/bin/bash
# Hardens a default Postfix install

# Backup the current/default config
postconf | sudo tee /root/postconf-$(date "+%F")

# Disable verify - stop user querying
postconf -e 'disable_vrfy_command=yes'

# Force HELO required
postconf -e 'smtpd_helo_required = yes'

# Set recipient, sender, security and relay restrictions
postconf -e 'smtpd_recipient_restrictions = permit_mynetworks, permit_sasl_authenticated, reject_unauth_destination, reject_rbl_client zen.spamhaus.org, reject_rhsbl_helo dbl.spamhaus.org, reject_rhsbl_sender dbl.spamhaus.org'
postconf -e 'smtpd_relay_restrictions = permit_mynetworks, permit_sasl_authenticated, reject_unauth_destination'

postconf -e 'smtpd_sasl_security_options = noanonymous'
postconf -e 'smtpd_sender_restrictions = reject_unknown_sender_domain'