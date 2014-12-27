#!/bin/bash
#Autoupdate CentOS 7 with CRON
#Description: This script will install CRON on your server
#Author: Max Kostinevich
#URL: https://github.com/maxkostinevich/server-shell-scripts/

clear

echo 'Installing CRON..'
# Install CRON
yum -y install yum-cron
chkconfig yum-cron on

service yum-cron start

#Final output
clear
echo 'CRON has been successfully installed and started'
echo 'You can edit CRON config in /etc/yum/yum-cron.conf'
echo 'Do not forget to restart CRON service after editing config' 
