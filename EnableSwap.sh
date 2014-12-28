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
sudo cd /var
sudo touch swap.img
sudo chmod 600 swap.img

# Set swap size
sudo dd if=/dev/zero of=/var/swap.img bs=1024 count="${swapSizeValue}k"

# Prepare the disk image
sudo mkswap /var/swap.img

# Enable swap file
sudo swapon /var/swap.img

# Mount swap on reboot
echo "/var/swap.img    none    swap    sw    0    0" >> /etc/fstab

# Change swappiness value
sudo sysctl -w vm.swappiness=30

#Final output
clear
echo -e "Swap file with size \e[1m$swapSizeValue Mb\e[0m  has been created successfully"
sudo free | grep Swap

echo 'Swapines value'
sudo sysctl -a | grep vm.swappiness

fi
