#!/bin/bash

# Disable root SSH login

if [ -f /etc/ssh/sshd_config ]; then
    sed -i 's/#PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
    systemctl restart sshd
    echo "Root SSH login disabled successfully"
else
    echo "sshd_config file not found."
fi
