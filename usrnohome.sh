#!/bin/bash

##Done for fun ##
##create a user without home dir##
echo "Enter the username to create"
read -p "username: " username

cat /etc/passwd | grep $username
cond="$?"
if [ $cond == "0" ]
then
	echo "User already exists"
else
	useradd -M $username
fi
