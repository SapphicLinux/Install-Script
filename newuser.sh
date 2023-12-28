#!/bin/bash

realname=""
username=""
syncrepo="git@github.com:user/repo.git"
syncprofile="desktop client"

# open fd
exec 3>&1

# Store data to $VALUES variable
VALUES=$(dialog --ok-label "Submit" \
	  --backtitle "Linux User Managment" \
	  --title "Useradd" \
	  --form "Create a new user" \
15 65 0 \
	"Real Name:"		1 1	"$realname" 	1 20 40 0 \
	"Username:"		2 1	"$username"  	2 20 40 0 \
	"Git Sync Repo:"	3 1	"$syncrepo"  	3 20 40 0 \
	"Git Sync Profiles:"	4 1	"$syncprofile" 	4 20 40 0 \
2>&1 1>&3)

# close fd
exec 3>&-

# display values just entered
echo "$VALUES"
readarray -t <<<$VALUES
#useradd -c "${MAPFILE[0]}" ${MAPFILE[1]}
usermod -aG sudo ${MAPFILE[1]}
echo "Created user \"${MAPFILE[0]}\" with username \"${MAPFILE[1]}\" "
userhome="/home/${MAPFILE[1]}"
sapconf="${userhome}/.config/sapphic-linux"
#mkdir -p ${sapconf}/sync/
#echo "${MAPFILE[2]}" > ${sapconf}/sync/repo
#echo "${MAPFILE[3]}" > ${sapconf}/sync/profiles
echo "Saved user sync settings"

data=$(tempfile 2>/dev/null)

# trap it
trap "rm -f $data" 0 1 2 5 15

dialog --title "Password" \
--clear --nocancel \
--passwordbox "Enter your password" 10 30 2> $data

#echo "${MAPFILE[1]}:${data}" | chpasswd

echo "Password has been set for ${MAPFILE[1]}"
