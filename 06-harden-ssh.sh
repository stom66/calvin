#!/bin/bash

# Configures SSHD to force keypair logins, disables root and password logins
declare PREFIX="Calvin | harden-ssh |"

# Change the port used for SSH
if [ ! -z "$1" ]; then
	echo "${PREFIX} SSH port changed to $1" >> ./calvin.log
	sed -i 's/#\?\(Port\s*\).*$/\1 ${1}/' /etc/ssh/sshd_config
fi

# Disable weak authentication
sed -i 's/#\?\(ChallengeResponseAuthentication\s*\).*$/\1 no/' /etc/ssh/sshd_config
sed -i 's/#\?\(PasswordAuthentication\s*\).*$/\1 no/' /etc/ssh/sshd_config

# Disable root logins
sed -i 's/#\?\(PermitRootLogin\s*\).*$/\1 no/' /etc/ssh/sshd_config

# Enable PAM
sed -i 's/#\?\(UsePAM\s*\).*$/\1 yes/' /etc/ssh/sshd_config

echo "${PREFIX} SSH Hardened" >> ./calvin.log

# Restart SSH Daemon
systemctl reload sshd

echo "${PREFIX} SSH Daemon restarted" >> ./calvin.log

