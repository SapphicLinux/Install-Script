#!/bin/bash

#./distribution.sh

#./newuser.sh

#dist=$(cat /root/.config/sapphic-linux/distribution)
dist=$(cat ./distribution)

./dists/${dist}.sh

#./hostname.sh

#./done.sh
