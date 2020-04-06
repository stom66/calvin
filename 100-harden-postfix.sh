#!/bin/bash
# Hardens a default Postfix install

# Backup the current/default config
postconf | sudo tee /root/postconf-$(date "+%F")

# Disable verify - stop user querying
postconf -e 'disable_vrfy_command=yes'

# Force HELO required
postconf -e 'smtpd_helo_required = yes'
