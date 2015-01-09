Server shell scripts
====================

Bunch of useful shell scripts which you can use to quick setup your VPS server.

These scripts are created to quick setup VPS server with CentOS 7 
 on [DigitalOcean](https://www.digitalocean.com/?refcode=12fe530260ed). 

##How to use

Login to your server as root, then download .sh scripts using **wget** command:

    wget -P /tmp  https://raw.githubusercontent.com/maxkostinevich/server-shell-scripts/master/EnableSwap.sh

And then run the script using **sh** or **bash** command:

    sh /tmp/EnableSwap.sh

##List of scripts with short description

**EnableSwap.sh** *(recommended)* — This script will help you to create swap file on your server.

**SetHostname** *(recommended)* — This script will help you to set hostname for your server.

**InitialSetup.sh** ***(highly recommended)*** — This script will help you to configure and secure your server:

    STEP 1: Update the system
    STEP 2: Create New User
    STEP 3: Add Public Key Authentication
    STEP 4: Configuring SSH
    STEP 5: Configuring a Basic Firewall
    STEP 6: Configuring Timezones and NTP

    ATTENTION!!!
    This script will disable root login;
    Also this script will disable authentication by password;
    Only authentication by ssh key will be allowed;

**InstallLAMP.sh** *(recommended)* — This script will install LAMP on your server.

**InstallPMA.sh** *(optional)*— This script will install PHPMyAdmin on your server.

**CreateVHost.sh** *(recommended)* — This script will help you to create new virtual host on you server.

**InstallVirtualMin.sh** *(optional)* — This script will install VirtualMin on your server.
