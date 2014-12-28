#!/bin/bash
#Install PHPMyAdmin on CentOS 7
#Description: This script will install PHPMyAdmin on your server
#Author: Max Kostinevich
#URL: https://github.com/maxkostinevich/server-shell-scripts/

clear

echo 'This script will install PHPMyAdmin on your server'
echo '---------------------------------------------'

#Get Server IP address
#serverIP=$(hostname -I)
serverIP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

#Install EPEL 
echo -e "\e[1mInstalling EPEL\e[0m"

sudo yum -y install epel-release

clear
echo -e "\e[1mEPEL has been installed and started successfully\e[0m"

#Install PHPMyAdmin
echo -e "\e[1mInstalling PHPMyAdmin\e[0m"

sudo yum -y install phpmyadmin

clear
echo -e "\e[1mPHPMyAdmin has been installed and started successfully\e[0m"

#Restart Apache
echo -e "\e[1mRestarting Apache\e[0m"

sudo systemctl restart httpd.service

clear
echo -e "\e[1mApache has been restarted successfully\e[0m"

#Final output
echo '---------------------------------------------'
echo 'PHPMyAdmin is available at the following address:'
echo -e "\e[1mhttp://${serverIP}/phpMyAdmin\e[0m"
echo '---------------------------------------------'
echo -e "\e[1mATTENTION!!!\e[0m"
echo 'Before you continue you should edit phpMyAdmin config file:'
echo -e "\e[1m/etc/httpd/conf.d/phpMyAdmin.conf\e[0m"
echo 'and replace "Require ip" with "Require all granted" rule'
echo 'and then restart Apache using the following command:'
echo -e "\e[1msystemctl restart httpd.service\e[0m"
echo '---------------------------------------------'
echo 'Read more about installing, configuring and securing PHPMyAdmin:'
echo 'https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-phpmyadmin-with-apache-on-a-centos-7-server'
echo 'http://www.krizna.com/centos/install-phpmyadmin-centos-7/'
echo '---------------------------------------------'
