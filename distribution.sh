#!/bin/bash

#if [[ $dist == "user" ]];then
#  role=$(grep users /etc/group | awk -F: '{print $4}')
#else
#  role=$dist
#fi
#manufacturer=$(dmidecode -s system-manufacturer | awk '{print $1}')
#sku=$(dmidecode -s system-sku-number)
#serial=$(dmidecode -s system-serial-number)
#devicename=$(echo "${role}-${manufacturer}${sku}-${serial}" | tr -dc '\-[:alnum:]\n\r' | tr '[:upper:]' '[:lower:]')
#echo $devicename

INPUT=/tmp/menu.sh.$$
trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

dialog --clear --backtitle "Linux Shell Script Tutorial" \
--title "[ SELECT DEPLOYMENT TYPE ]" \
--menu "Use the UP/DOWN arrow keys, the first letter of the choice\n\
as a hot key, or the number keys 1-9 to choose an option." 15 75 4 \
user "Single-User Device with Desktop Environment" \
common "Multi-User Device with Desktop Environment" \
kiosk "Single-Profile Public Device with Desktop Environment" \
server "Headless Environment Intended to be Accessed Remotely" \
2>"${INPUT}"

menuitem=$(<"${INPUT}")

#echo $menuitem > /root/.config/sapphic-linux/distribution
echo $menuitem

# display values just entered
#echo "$VALUES" > /etc/hostname
#hostnamectl set-hostname $devicename
#sed -i s/sapphic-installer/$devicename/ /etc/hosts
#hostname $devicename
