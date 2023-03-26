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

# Check if haproxy is installed
if ! command -v haproxy &> /dev/null
then
    # Install the haproxy package
    sudo yum install haproxy -y
else
    # Print a message indicating haproxy is already installed
    echo "HAProxy is already installed."
fi

#Create a new logrotate configuration file for haproxy
sudo tee /etc/logrotate.d/haproxy << EOF
/path/to/haproxy.log {
    monthly
    rotate 3
    compress
    delaycompress
    notifempty
    missingok
    create 644 haproxy haproxy
}
EOF

# Check the syntax of the logrotate configuration file
sudo logrotate -d /etc/logrotate.d/haproxy

# Reload the haproxy service to pick up the changes
sudo systemctl restart haproxy.service
