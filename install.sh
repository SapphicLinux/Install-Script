#!/bin/bash

lsblk -o NAME,MOUNTPOINT -n -l | awk '$2 == "" {print $1}'
