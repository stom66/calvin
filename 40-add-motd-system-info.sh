#!/bin/bash

# Enables an MotD with system info and basic "LS" logo

# Logging
declare PREFIX="Calvin | add-motd |"

sed -i 's/#\?\(PrintMotd\s*\).*$/\1 no/' /etc/ssh/sshd_config

echo "${PREFIX} Updated sshd_config" >> ./calvin.log

systemctl restart sshd
cp ./resources/motd.ls.sh /etc/profile.d/sysinfo.motd.sh
echo "${PREFIX} Installed and enabled SysInfo MotD" >> ./calvin.log

chmod +x /etc/profile.d/sysinfo.motd.sh
echo "${PREFIX} SSH Daemon restarted" >> ./calvin.log
