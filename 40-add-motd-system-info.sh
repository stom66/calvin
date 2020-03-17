#!/bin/bash

# setup an motd with system info and space for server logo
sed -i '/^#.*PrintMotd/s/^#//' /etc/ssh/sshd_config
sed -i '/^PrintMotd/s/yes/no/' /etc/ssh/sshd_config
systemctl restart sshd
wget -O /etc/profile.d/sysinfo.motd.sh https://raw.githubusercontent.com/stom66/code-golf/master/bash/motd/sysinfo.motd.sh
chmod +x /etc/profile.d/sysinfo.motd.sh