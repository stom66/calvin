#!/bin/bash
# get cpu info
CPUNAME=`lscpu | sed -nr '/Model name/ s/.*:\s*(.*)*/\1/p'`

# get mem info
MEM_FREE=`cat /proc/meminfo | grep MemFree | awk {'print $2'}`
MEM_TOTAL=`cat /proc/meminfo | grep MemTotal | awk {'print $2'}`

let MEM_FREE=MEM_FREE/1024
let MEM_TOTAL=MEM_TOTAL/1024
let MEM_USED=MEM_TOTAL-MEM_FREE
read one five fifteen rest < /proc/loadavg

# get network info
HOSTNAME=`hostname`
IP_INT=`ip a | grep glo | awk '{print $2}' | head -1 | cut -f1 -d/`
IP_EXT=`wget -q -O - http://icanhazip.com/ | tail`

# get uptime
upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
secs=$((${upSeconds}%60))
mins=$((${upSeconds}/60%60))
hours=$((${upSeconds}/3600%24))
days=$((${upSeconds}/86400))

UPTIME=`printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`

echo "
$(tput setaf 7)   ++====================++ 
$(tput setaf 7)   ||                    || $(tput setaf 2)   `date +"%A, %e %B %Y, %r"`
$(tput setaf 7)   ||                    || $(tput setaf 2)   `uname -srmo`
$(tput setaf 7)   ||  ██╗     ███████╗  || $(tput setaf 6)   Hostname:    ${HOSTNAME}
$(tput setaf 7)   ||  ██║     ██╔════╝  || $(tput setaf 6)   IPs:         ${IP_EXT} (external)
$(tput setaf 7)   ||  ██║     ███████╗  || $(tput setaf 6)                ${IP_INT} (internal)
$(tput setaf 7)   ||  ██║     ╚════██║  || $(tput setaf 6)   Uptime:      ${UPTIME}
$(tput setaf 7)   ||  ███████╗███████║  || $(tput setaf 6)   CPU:         ${CPUNAME}
$(tput setaf 7)   ||  ╚══════╝╚══════╝  || $(tput setaf 6)   Memory:      ${MEM_USED}MB of ${MEM_TOTAL}MB
$(tput setaf 7)   ||                    || $(tput setaf 6)   Processes:   `ps ax | wc -l | tr -d " "` 
$(tput setaf 7)   ||                    || $(tput setaf 6)   Load:        ${one}, ${five}, ${fifteen} (1, 5, 15 min)
$(tput setaf 7)   ++====================++
$(tput sgr0)"