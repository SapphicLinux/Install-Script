#!/bin/bash

echo -e "device\ttype\tlabel\tformat\tsize"

print_device_info() {
    local device=$1
    local indent=$2

    # Get device info
    local type=$(lsblk -no TYPE $device)
    local label=$(lsblk -no LABEL $device)
    local format=$(lsblk -no FSTYPE $device)
    local size=$(lsblk -no SIZE $device)

    # Print device info
    echo -e "$indent$device\t$type\t$label\t$format\t$size"

    # Check if the device has partitions
    local partitions=($(lsblk -no NAME $device | grep -E "${device}[0-9]+"))
    for partition in "${partitions[@]}"; do
        print_device_info "$partition" "$indent    "
    done
}

# Get a list of unmounted block devices
devices=($(lsblk -rno NAME,PATH,MOUNTPOINT | awk '$3 == "" {print $2}'))

# Iterate over unmounted devices
for device in "${devices[@]}"; do
    print_device_info "$device" ""
done
