#!/bin/bash

#check if the script is run as root
if [ "$(id -u)" != "0" ];
then
	echo "This script is not run as root."
	exit 1
fi

#prompt for username

read -p "Enter the username: " username

#path to sudoers file
sudoers_file="/etc/sudoers"
temp_file="/etc/sudoers.tmp"

#Backup sudoes file
cp $sudoers_file $temp_file

#Add the passwordless sudo entry for the user

echo "$username ALL=(ALL) NOPASSWD:ALL" >> $temp_file

#update the sudoers file
visudo -c -f $temp_file
if [ $? -eq 0 ];
then
	cp $temp_file $sudoers_file
	echo "Passwordless sudo has been granted to $username."
else
	echo "Failed to grant sudo access to $username."
fi

#remove temp file
rm $temp_file

