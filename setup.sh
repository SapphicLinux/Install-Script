#!/bin/bash

script_root=$(dirname $0)

${script_root}/distribution.sh

${script_root}/newuser.sh

${script_root}/shell.sh

dist=$(cat /root/.config/sapphic-linux/distribution)
#dist=$(cat ./distribution)

${script_root}/dists/${dist}.sh

${script_root}/hostname.sh

${script_root}/done.sh
