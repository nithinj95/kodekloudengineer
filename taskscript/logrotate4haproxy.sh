#!/bin/bash
# Check if logrotate is installed
if ! command -v logrotate &> /dev/null
then
    # Install the logrotate package
    sudo yum install logrotate -y
else
    #print a message logrotate is installed
    echo "Logrotate is already installed."
fi

# Check if squid is installed
if ! command -v squid &> /dev/null
then
    # Install the squid package
    sudo yum install squid -y
else
    # Print a message indicating squid is already installed
    echo "squid is already installed."
fi

#Create a new logrotate configuration file for squid
sudo tee /etc/logrotate.d/squid << EOF
/var/log/squid.log {
    monthly
    rotate 3
    compress
    delaycompress
    notifempty
    missingok
}
EOF

# Check the syntax of the logrotate configuration file
sudo logrotate -d /etc/logrotate.d/squid

# Reload the squid service to pick up the changes
sudo systemctl restart squid.service
