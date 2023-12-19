#!/bin/bash

device_list=()
print_device_info() {
    local device=$1

    # Get device info
    device_list+=("$indent$device")
    local size=$(lsblk --nodeps -rno SIZE $device)

    let treelvl=$indentlen/2
    local devinfo=$(printf "%-10s \n" "$size")
    device_list+=("$devinfo")

}

# Get a list of unmounted block devices
devices=($(lsblk -rno NAME,PATH,TYPE | awk '$3 == "disk" {print $2}')) #disks only

# Iterate over unmounted devices
for device in "${devices[@]}"; do
    print_device_info $device
done

dialog --menu "Select the disk that SapphicOS will be installed to." -1 -1 0 "${device_list[@]}" 2> ~/tmp/install_disk
