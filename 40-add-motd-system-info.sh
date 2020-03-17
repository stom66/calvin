#!/bin/bash

# Enables an MotD with system info and basic "LS" logo

sed -i '/^#.*PrintMotd/s/^#//' /etc/ssh/sshd_config
sed -i '/^PrintMotd/s/yes/no/' /etc/ssh/sshd_config
systemctl restart sshd
cp ./resources/motd.ls.sh /etc/profile.d/sysinfo.motd.sh
chmod +x /etc/profile.d/sysinfo.motd.sh