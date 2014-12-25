#!/bin/bash
#Create swap file
#Description: This script will create swap file on your server
#Author: Max Kostinevich
#URL: https://github.com/maxkostinevich/server-shell-scripts/

clear

swaponState=$(swapon -s)
if [[ -n $swaponState ]]
then

clear
echo 'The swap file is already enabled on your server'

else

echo 'This script will create swap file on your server'
echo '------------------------------------------------'
read -p "Swap size (Mb): " swapSizeValue
read -p "Swappiness value (1-100): " swappinessValue

clear
echo 'Enabling swap file in progress..Please wait'

# Create swap file
cd /var
touch swap.img
chmod 600 swap.img

# Set swap size
dd if=/dev/zero of=/var/swap.img bs=1024 count="${swapSizeValue}k"

# Prepare the disk image
mkswap /var/swap.img

# Enable swap file
swapon /var/swap.img

# Mount swap on reboot
echo "/var/swap.img    none    swap    sw    0    0" >> /etc/fstab

# Change swappiness value
sysctl -w vm.swappiness=30

#Final output
clear
echo -e "Swap file with size \e[1m$swapSizeValue Mb\e[0m  has been created successfully"
free | grep Swap

echo 'Swapines value'
sysctl -a | grep vm.swappiness

fi
