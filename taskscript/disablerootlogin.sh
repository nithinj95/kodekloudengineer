#!/bin/bash

# Disable root SSH login

if [ -f /etc/ssh/sshd_config ]; then
    sed '/PermitRootLogin yes/a PermitRootLogin no' /etc/ssh/sshd_config
    systemctl restart sshd
    echo "Root SSH login disabled successfully"
else
    echo "sshd_config file not found."
fi
