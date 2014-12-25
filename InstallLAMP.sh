#!/bin/bash
#Install LAMP on CentOS 7
#Description: This script will install Apache, MySQL and PHP on your server
#Author: Max Kostinevich
#URL: https://github.com/maxkostinevich/server-shell-scripts/

clear

echo 'This script will install LAMP on your server'
echo '---------------------------------------------'

#Get Server IP address
#serverIP=$(hostname -I)
serverIP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

#Install Apache
echo -e "\e[1mInstalling Apache\e[0m"

yum -y install httpd
systemctl start httpd.service

clear
echo -e "\e[1mApache has been installed and started successfully\e[0m"

#Install MySQL
echo -e "\e[1mInstalling MySQL\e[0m"

yum install mariadb-server mariadb
systemctl start mariadb
mysql_secure_installation
systemctl enable mariadb.service

clear
echo -e "\e[1mMySQL has been installed and started successfully\e[0m"

#Install PHP
echo -e "\e[1mInstalling PHP\e[0m"

yum -y install php php-mysql
yum -y install php-cli php-common php-fpm php-gd php-intl php-mbstring php-pear php-pecl-memcache php-xml
systemctl restart httpd.service

clear
echo -e "\e[1mPHP has been installed successfully\e[0m"

#Firewall
echo -e "\e[1mUpdating Firewall\e[0m"

systemctl enable firewalld
systemctl start firewalld

firewall-cmd --permanent --zone=public --add-service=http 
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload

clear
echo -e "\e[1mFirewall has been updated successfully\e[0m"

#Create test PHP-Info
printf  '<?php phpinfo(); ?>' > /var/www/html/info.php
echo '---------------------------------------------'
echo 'info.php file has been created successfully'
echo -e "You can check it in your browser: \e[1mhttp://${serverIP}/info.php\e[0m"
echo 'You can remove info.php file using the following command:'
echo -e "\e[1mrm /var/www/html/info.php\e[0m"
echo '---------------------------------------------'
