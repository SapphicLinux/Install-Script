#!/bin/bash

print_device_info() {
    local device=$1

    # Get device info
    local name=$(lsblk -rno PATH,NAME | awk -v d=$device '$1 == d {print $2 $3}')
    local indent=$(lsblk -no NAME | grep "$name$" | sed s/$name//)
    local indentname="$indent$name"
    local type=$(lsblk -rno PATH,TYPE | awk -v d=$device '$1 == d {print $2}')
    local label=$(lsblk -rno PATH,LABEL | awk -v d=$device '$1 == d {print $2}')
    local format=$(lsblk -rno PATH,FSTYPE | awk -v d=$device '$1 == d {print $2}')
    local size=$(lsblk -rno PATH,SIZE | awk -v d=$device '$1 == d {print $2}')

    #format
    indentlen=${#indent}
    let namecol=30-$indentlen
    let treelvl=$indentlen/2
    #print
    #printf "$indent%-${namecol}s | %-10s | %-15s | %-20s | %-10s \n" "$name" "$type" "$label" "$format" "$size"
    printf "%-10s | %-15s | %-20s | %-10s \n" "$type" "$label" "$format" "$size"
    #echo "$type $label $format $size"

}

# Get a list of unmounted block devices
#devices=($(lsblk -rno NAME,PATH,MOUNTPOINT | awk '{print $2}')) #all block devices
devices=($(lsblk -rno NAME,PATH,MOUNTPOINT | awk '$3 == "" {print $2}')) #unmounted block devices

printf "\e[4;1m%-30s | %-10s | %-15s | %-20s | %-10s \e[0m\n" "Device" "Type" "Label" "Format" "Size" #print header

DeviceList=()
# Iterate over unmounted devices
for device in "${devices[@]}"; do
    DeviceList+=($device)
    DeviceList+=("$(print_device_info $device)")
done



#echo "${DeviceList[@]}"

dialog --menu "Partitioner_menu" 0 0 0 "${DeviceList[@]}"
