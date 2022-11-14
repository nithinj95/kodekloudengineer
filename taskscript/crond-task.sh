#!/bin/bash

#check if cron is installed
systemctl status crond
install="$?"

if [ $install == "0" ]
then
	echo "cronie already installed, creating a job"
else
	#install cronie and start
	yum install cronie -y
	systemctl restart crond
	systemctl enable crond
fi


#create a cron job
read -p 'user for which the cron job to be created: ' cronuser
cronfile="/var/spool/cron/$cronuser"
if [ ! -f $cronfile ]
then
	echo "cron file for $cronuser doesnot exist, creating.."
	touch $cronfile
	/usr/bin/crontab $cronfile
	echo "*/5 * * * * echo hello > /tmp/cron_text" >> $cronfile
fi

#cron job list
crontab -u $cronuser -l
