#!/bin/bash

#Install tomcat and enable it
yum install tomcat -y
systemctl restart tomcat
systemctl enable tomcat
systemctl status tomcat

#Install logrotate
yum install logrotate -y
logrotate --version

#path to the logrotate config file
logrotate_file="/etc/logrotate.d/tomcat"

#backup the original config
cp $logrotate_file "$logrotate_file.bak"

#create new config
echo -e "/opt/tomcat/logs/*.log {
    monthly
    rotate 3
    copytruncate
    compress
    missingok
    dateext
}" > $logrotate_file

#test the new config
logrotate -d $logrotate_file
