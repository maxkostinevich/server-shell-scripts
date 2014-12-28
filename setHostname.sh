#!/bin/bash
#Set hostname on CentOS 7
#Description: This script will help you to setup correct hostname
#Author: Max Kostinevich
#URL: https://github.com/maxkostinevich/server-shell-scripts/

clear

echo 'This script will help you to setup correct hostname'
echo '------------------------------------------------------'

#Get Server hostname
serverHostname=$(hostname -f)

echo -e "Current hostname is \e[1m${serverHostname}\e[1m"

#Set new hostname
read -p "Enter new hostname: " newHostname
sudo hostnamectl set-hostname "${newHostname}"

clear
echo -e "\e[1mServer hostname has been updated successfully\e[0m"

#Final output
echo '---------------------------------------------'
hostnamectl status
echo '---------------------------------------------'
