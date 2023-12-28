#!/bin/bash

if [[ $dist == "user" ]];then
  role=$(grep users /etc/group | awk -F: '{print $4}' | head -n 1)
else
  role=$dist
fi
manufacturer=$(dmidecode -s system-manufacturer | awk '{print $1}')
sku=$(dmidecode -s system-sku-number)
serial=$(dmidecode -s system-serial-number)
devicename=$(echo "${role}-${manufacturer}${sku}-${serial}" | tr -dc '\-[:alnum:]\n\r' | tr '[:upper:]' '[:lower:]')
echo $devicename

# open fd
exec 3>&1

# Store data to $VALUES variable
VALUES=$(dialog --ok-label "Submit" --nocancel \
	  --backtitle "Linux User Managment" \
	  --title "Useradd" \
	  --form "Create a new user" \
15 65 0 \
	"Hostname:"		1 1	"$devicename" 	1 20 40 0 \
2>&1 1>&3)

# close fd
exec 3>&-

# display values just entered
#echo "$VALUES" > /etc/hostname
#hostnamectl set-hostname $devicename
#sed -i s/sapphic-installer/$devicename/ /etc/hosts
#hostname $devicename
