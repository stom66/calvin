#!/bin/bash

# Configures SSHD to force keypair logins, disables root and password logins
declare PREFIX="Calvin | harden-ssh |"


#sed -i 's/#\?\(Port\s*\).*$/\1 2231/' /etc/ssh/sshd_config
sed -i 's/#\?\(ChallengeResponseAuthentication\s*\).*$/\1 no/' /etc/ssh/sshd_config
sed -i 's/#\?\(PasswordAuthentication\s*\).*$/\1 no/' /etc/ssh/sshd_config
sed -i 's/#\?\(PermitRootLogin\s*\).*$/\1 no/' /etc/ssh/sshd_config
sed -i 's/#\?\(UsePAM\s*\).*$/\1 yes/' /etc/ssh/sshd_config

echo "${PREFIX} Disabled ssh password auth and root logins" >> ./calvin.log

# Restart SSH Daemon
systemctl reload sshd

echo "${PREFIX} SSH Daemon restarted" >> ./calvin.log

