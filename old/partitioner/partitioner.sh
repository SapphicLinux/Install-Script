#!/bin/bash

script_root=$(dirname "$0")

dialog --menu "Partitioner_menu" -1 -1 0 "1" "Single Partition" "2" "Separate /home Partition" "3" "Separate /home, /var, /tmp Partitions" "4" "Manual Partitioning" 2> ~/tmp/part_method

part_method=$(cat /tmp/sapphic_part_method) && rm /tmp/sapphic_part_method

if [ $part_method -lt 4 ];then
  $script_root/partitioner/automatic.sh $part_method
else
  $script_root/partitioner/manual.sh
fi
