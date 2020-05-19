#!/bin/bash
# Hardens a default Postfix install

# Backup the current/default config
postconf | sudo tee /root/postfix.main.cf.$(date "+%F-%T")

# Disable verify - stop clients querying for valid users
postconf -e 'disable_vrfy_command = yes'

# Force HELO required
postconf -e 'smtpd_helo_required = yes'
postconf -e 'smtpd_helo_restrictions = permit_mynetworks permit_sasl_authenticated reject_invalid_helo_hostname reject_non_fqdn_helo_hostname reject_unknown_helo_hostname'

# Encourage the use of TLS
postconf -e 'smtp_tls_security_level = may'
postconf -e 'smtp_tls_note_starttls_offer = yes'
postconf -e 'smtp_use_tls = yes'
postconf -e 'smtpd_use_tls = yes'
postconf -e 'smtpd_tls_security_level = may'
postconf -e 'smtpd_sasl_auth_enable = yes'

# Limit the rate of incoming connections
postconf -e 'smtpd_client_connection_count_limit = 10'
postconf -e 'smtpd_client_connection_rate_limit = 60'

# Set client, recipient, relay & sender security and relay restrictions
postconf -e 'smtpd_client_restrictions = permit_mynetworks permit_sasl_authenticated reject_unauth_destination reject_rbl_client zen.spamhaus.org reject_rbl_client bl.spamcop.net reject_rbl_client cbl.abuseat.org permit'
postconf -e 'smtpd_recipient_restrictions = permit_mynetworks permit_sasl_authenticated reject_unauth_destination reject_rbl_client zen.spamhaus.org reject_rhsbl_reverse_client dbl.spamhaus.org reject_rhsbl_helo dbl.spamhaus.org reject_rhsbl_sender dbl.spamhaus.org'
postconf -e 'smtpd_relay_restrictions = permit_mynetworks permit_sasl_authenticated reject_unauth_destination'
postconf -e 'smtpd_sender_restrictions = permit_mynetworks permit_sasl_authenticated reject_unknown_sender_domain'
postconf -e 'smtpd_sasl_security_options = noanonymous'

# Reload postfix
postfix reload
systemctl restart postfix