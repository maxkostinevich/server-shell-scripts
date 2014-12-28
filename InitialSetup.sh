#!/bin/bash
#Initial server setup with CentOS 7
#Description: This script will help you to configure your server
#Author: Max Kostinevich
#URL: https://github.com/maxkostinevich/server-shell-scripts/

clear

echo 'This script will help you to configure your server'
echo '---------------------------------------------'
echo 'Steps:'
echo -e "\e[1mSTEP 1:\e[0m Update the system"
echo -e "\e[1mSTEP 2:\e[0m Create New User"
echo -e "\e[1mSTEP 3:\e[0m Add Public Key Authentication"
echo -e "\e[1mSTEP 4:\e[0m Configuring SSH"
echo -e "\e[1mSTEP 5:\e[0m Configuring a Basic Firewall"
echo -e "\e[1mSTEP 6:\e[0m Configuring Timezones and NTP"
echo '---------------------------------------------'
echo -e "\e[1mATTENTION!!!\e[0m"
echo 'This script will disable root login'
echo 'Also this script will disable authentication by password'
echo 'Only authentication by ssh key will be allowed'
echo '---------------------------------------------'
echo 'PRESS ANY KEY TO CONTINUE'
read -n 1 -s
clear

#STEP 1 - Update the system
echo -e "\e[1mSTEP 1: Update the system \e[0m" 

sudo yum -y update

clear
echo -e "\e[1mSystem has been updated successfully\e[0m"

#Install CRON
echo -e "\e[1mInstalling CRON \e[0m" 

sudo yum -y install yum-cron
sudo chkconfig yum-cron on
sudo service yum-cron start

clear
echo -e "\e[1mCRON has been successfully installed and started\e[0m"


#STEP 2 - Create New User
echo -e "\e[1mSTEP 2: Create New User \e[0m" 

read -p "Enter new username (e.g. admin): " newUser
#Create User
sudo adduser "$newUser"
sudo passwd "$newUser"
#Grant new user the root privileges
sudo passwd -a "$newUser" wheel

clear
echo -e "\e[1mUser '${newUser}' with the root privileges has been created\e[0m"

#STEP 3 - Add Public Key Authentication
echo -e "\e[1mSTEP 3: Add Public Key Authentication \e[0m" 

read -p "Enter your public key for user '${newUser}': " publicKey


sudo mkdir "/home/${newUser}/.ssh"
sudo chmod 700 "/home/${newUser}/.ssh"
sudo printf  "$publicKey" > "/home/${newUser}/.ssh/authorized_keys"
sudo chmod 600 "/home/${newUser}/.ssh/authorized_keys"
sudo chown "${newUser}:${newUser}" "/home/${newUser}/.ssh"
sudo chown "${newUser}:${newUser}" "/home/${newUser}/.ssh/authorized_keys"

#su - "$newUser"
#mkdir .ssh
#chmod 700 .ssh
#printf  "$publicKey" > ".ssh/authorized_keys"
#chmod 600 .ssh/authorized_keys

clear
echo -e "\e[1mPublic key has been added successfully\e[0m"

#STEP 4 - Configuring SSH
echo -e "\e[1mSTEP 4: Configuring SSH \e[0m" 

read -p "Enter new SSH port (49152-65536): " newSSHPort

#Backup SSH config
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config_BACKUP

#Change SSH port
sudo sed -i "/#Port 22/a Port ${newSSHPort}" /etc/ssh/sshd_config

#Restrict Root Login
sudo sed -i "/#PermitRootLogin yes/a PermitRootLogin no" /etc/ssh/sshd_config

#Disable authentication by password and enable authentication by ssh key
sudo sed -i "/#RSAAuthentication yes/a RSAAuthentication yes" /etc/ssh/sshd_config
sudo sed -i "/#PubkeyAuthentication yes/a PubkeyAuthentication yes" /etc/ssh/sshd_config
sudo sed -i "s/PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config

sudo systemctl reload sshd.service

clear
echo -e "\e[1mSSH config has been updated successfully\e[0m"

#STEP 5 - Configuring a Basic Firewall
echo -e "\e[1mSTEP 5: Configuring a Basic Firewall \e[0m" 

sudo systemctl start firewalld

#If port SSH has NOT changed
#sudo firewall-cmd --permanent --add-service=ssh

#If port SSH has BEEN changed
sudo firewall-cmd --permanent --remove-service=ssh
sudo firewall-cmd --permanent --add-port="${newSSHPort}/tcp"
#HTTP
sudo firewall-cmd --permanent --add-service=http
#HTTPS
sudo firewall-cmd --permanent --add-service=https
#SMTP
sudo firewall-cmd --permanent --add-service=smtp

#Reload firewall
sudo firewall-cmd --reload

sudo systemctl enable firewalld

#firewall-cmd --list-ports

clear
echo -e "\e[1mFirewall has been updated successfully\e[0m"

#STEP 6 - Configuring Timezones and NTP
echo -e "\e[1mSTEP 6: Configuring Timezones and NTP \e[0m" 

#Timezone
read -p "Enter server timezone (e.g. America/New_York): " serverTimezone
#sudo timedatectl list-timezones
sudo timedatectl set-timezone "$serverTimezone"

#timedatectl -> check current settings

#NTP (Network Time Protocol Synchronization)
echo -e "\e[1mEnable NTP\e[0m"

sudo yum -y install ntp
sudo systemctl start ntpd
sudo systemctl enable ntpd

clear
echo -e "\e[1mNetwork Time Protocol Synchronization (NTP) has been successfully installed and enabled\e[0m"

#Final output
echo '-------------------------------------------------------'
echo 'Initial server setup has been completed successfully'
echo '-------------------------------------------------------'
echo 'Details:'
echo '1. System has been updated'
echo '2. CRON has been installed and started'
echo -e "3. User \e[1m${newUser}\e[0m with the root privileges has been created"
echo '4. Public SSH key for new user has been added successfully'
echo '5. SSH config has been updated:'
echo -e "  - New SSH port is \e[1m${newSSHPort}\e[0m"
echo '  - Root login has been disabled'
echo '  - Authentication by password has been disabled'
echo '  - SSH config backup: /etc/ssh/sshd_config_BACKUP'
echo '6. Firewall has been enabled'
echo '6. Firewall rules has been updated'
echo '7. Server timezone has been updated'
echo '8. Network Time Protocol Synchronization (NTP) has been enabled'
echo '---------------------------------------------'
echo 'Read more about initial server setup:'
echo 'https://www.digitalocean.com/community/tutorials/initial-server-setup-with-centos-7'
echo 'https://www.digitalocean.com/community/tutorials/additional-recommended-steps-for-new-centos-7-servers'
echo '---------------------------------------------'
