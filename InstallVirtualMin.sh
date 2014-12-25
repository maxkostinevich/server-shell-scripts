#!/bin/bash
#Install VirtualMin on CentOS 7
#Description: This script will install VirtualMin on your server
#Author: Max Kostinevich
#URL: https://github.com/maxkostinevich/server-shell-scripts/

clear

echo 'This script will install VirtualMin on your server'
echo '---------------------------------------------'

#Get Server IP address
#serverIP=$(hostname -I)
serverName=$(hostname -f)
serverIP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

#Downloading VirtualMin
echo -e "\e[1mDownloading VirtualMin installer\e[0m"

wget http://software.virtualmin.com/gpl/scripts/install.sh -O /tmp/virtualmin-install.sh

clear
echo -e "\e[1mVirtualMin installer has been downloaded successfully\e[0m"

#Run Installer
echo -e "\e[1mInstalling VirtualMin\e[0m"

sh /tmp/virtualmin-install.sh

clear
echo -e "\e[1mVirtualMin has been installed successfully\e[0m"


#Final output
echo '---------------------------------------------'
echo 'VirtualMin is available at the following address:'
echo -e "\e[1mhttp://${serverName}:10000\e[0m"
echo '---------------------------------------------'
echo 'Read more about VirtualMin:'
echo 'https://www.digitalocean.com/community/tutorials/how-to-install-and-utilize-virtualmin-on-a-vps'
echo '---------------------------------------------'
