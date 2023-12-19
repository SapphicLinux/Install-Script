#!/bin/bash

script_root=$(dirname "$0")

$script_root/partitioner/disk_menu.sh
install_disk=$(cat ~/tmp/install_disk)

#parted $install_disk mklabel gpt --script

system_memory=$(grep MemTotal /proc/meminfo | awk '{print $2}')
let target_disk_size=$(lsblk --nodeps -nbo SIZE $install_disk)/1024
awk -v m=$system_memory -v d=$target_disk_size 'BEGIN{printf("%.0f\n",m/d)}'
let swap_pct=$system_memory/$target_disk_size
let root_pct=100-$swap_pct

parted $install_disk mkpart root ext4 0% 
