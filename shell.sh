#!/bin/bash

script_root=$(dirname $0)

sudo apt -y install pipx toilet figlet
pipx install hyfetch
pipx ensurepath

sudo mkdir -p /etc/skel/.bash_source/
sudo cp ${script_root}/skel/.bash_source/sapphrc /etc/skel/.bash_source/sapphrc
sudo cp ${script_root}/skel/.bash_source/template /etc/skel/.bash_source/${device_type}
sudo cp ${script_root}/skel/.bash_source/template /etc/skel/.bash_source/custom

sudo chmod +x /etc/skel/bash_source/*

sudo echo "source ~/.bash_source/sapphrc" >> /etc/skel/.bashrc
