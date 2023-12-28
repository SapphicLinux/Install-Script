#!/bin/bash

menulist=()

get_children(){
  local device=$1
#  local padding=$2
  #echo ${#blockinfo[@]}
#  local name=$(lsblk --nodeps PATH,NAME | awk -v d=$device '$1 == d {print $2 $3}')
#  local indent=$(lsblk -no NAME | grep "$name$" | sed s/$name//)
#  children=($(lsblk -rno PATH,NAME $device | awk '($0 != " `" {print $0}'))
#  local children=($(lsblk -ino NAME $device | awk '$0 !~ " `" {print $0}' | tail -n +2))
  devout=$(lsblk -rno PATH --nodeps $device)
  local padding=""
  menulist+=("${padding}${devout}")
  local type=$(lsblk -rno PATH,TYPE | awk -v d=$device '$1 == d {print $2}')
  local label=$(lsblk -rno PATH,LABEL | awk -v d=$device '$1 == d {print $2}')
  local format=$(lsblk -rno PATH,FSTYPE | awk -v d=$device '$1 == d {print $2}')
  local size=$(lsblk -rno PATH,SIZE | awk -v d=$device '$1 == d {print $2}')
  devinfo=$(printf "%-10s | %-15s | %-20s | %-10s" "$type" "$label" "$format" "$size")
  menulist+=("$devinfo")
#  if [ ${#children[@]} -gt "0" ];then
#    subdevices=($(lsblk -rno PATH $device | awk -v d=$device '$1 != d {print $1}'))
#    for child in ${children[@]};do
#      echo $child
#      childpath=$(lsblk -ino PATH,NAME | awk -v d=$device -v c=$child '$2 == c {print $1}')
#      get_children $childpath "${padding}  "
#    done
#  fi
}

#disks=($(lsblk -o PATH,TYPE | awk '$2 == "disk" {print $1}'))
disks=($(lsblk --sort NAME -o PATH,TYPE | awk '{print $1}'))
#echo ${disks[@]}

menulist=()
for disk in "${disks[@]}";do
  get_children $disk ""
done

for i in "${menulist[@]}";do
  echo $i
done
#echo "${menulist[@]}"

dialog --menu "partitioner" -1 -1 0 "${menulist[@]}"
