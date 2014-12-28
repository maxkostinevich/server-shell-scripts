#!/bin/bash
#Install WordPress on CentOS 7
#Description: This script will help you to install WordPress on your server
#Author: Max Kostinevich
#URL: https://github.com/maxkostinevich/server-shell-scripts/

clear

echo 'This script will help you to install WordPress on your server'
echo '------------------------------------------------------'
echo -e "\e[1mATTENTION!!!\e[0m"
echo 'This script works properly only with Virtual Hosts which are created by CreateVHost.sh;'
echo 'LAMP stack should be already installed on your server;'
echo 'You can create new virtual host for your Wordpress installation using the following script:'
echo 'https://raw.githubusercontent.com/maxkostinevich/server-shell-scripts/master/CreateVHost.sh'
echo '------------------------------------------------------'
echo 'PRESS ANY KEY TO CONTINUE'
read -n 1 -s
clear

echo -e "\e[1mAvailable folders to install WordPress:\e[0m"
ls -I cgi-bin -I html -I public_html /var/www/
read -p "Enter folder name to install WordPress: " folderName
read -p "Enter WordPress subfolder (or leave it blank): " wpFolder

clear
#Download WordPress
echo -e "\e[1mInstalling WordPress\e[0m"
wget -P /tmp http://wordpress.org/latest.tar.gz
sudo tar xzvf /tmp/latest.tar.gz

#Copy WordPress
sudo rsync -avP /tmp/wordpress/ /var/www/$folderName/public_html/$wpFolder

#Delete downloaded files
sudo rm -rf /tmp/latest.tar.gz
sudo rm -rf /tmp/wordpress

#Create uploads folder
mkdir /var/www/$folderName/public_html/$wpFolder/wp-content/uploads
#Change folder owner to 'apache'
sudo chown -R apache:apache /var/www/$folderName/public_html/*

#Create config.php
cp /var/www/$folderName/public_html/$wpFolder/wp-config-sample.php /var/www/$folderName/public_html/$wpFolder/wp-config.php

clear

#Final output
echo '-------------------------------------------------------'
echo 'WordPress has been installed successfully'
echo '-------------------------------------------------------'
echo 'Further steps:'
echo -e "Edit wp-config file: \e[1m/var/www/${folderName}/public_html/${wpFolder}/wp-config.php\e[0m"
echo 'Finish WordPress installation through  the Web inteface'
echo '---------------------------------------------'
echo 'Read more about installing WordPress on CentOS 7:'
echo 'https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-on-centos-7'
echo '---------------------------------------------'
