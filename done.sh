#!/bin/bash

#passwd root -ld

echo "The root user has been disabled. Use 'sudo' to run commands with root privileges."
echo "Installation is complete! The system will restart now. After restarting, you will be able to log in with the account you've just created."

touch /root/.config/sapphic-linux/setupcomplete
reboot now
