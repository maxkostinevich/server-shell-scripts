#!/bin/bash
#Create new Virtual Host on CentOS 7
#Description: This script will create new virtual host (Apache, CentOS 7)
#Author: Max Kostinevich
#URL: https://github.com/maxkostinevich/server-shell-scripts/

clear

echo 'This script will create new virtual host'
echo '---------------------------------------------'
read -p "Enter domain name: " domainName
read -p "Enter folder name: " folderName

#Install bind utils
echo -e "\e[1mInstalling bind utils \e[0m" 

sudo yum -y install bind-utils

clear
echo -e "\e[1mBind utils has been installed successfully\e[0m"

#Create website directory
echo -e "\e[1mCreate website directory \e[0m" 

sudo mkdir -p "/var/www/${folderName}/public_html"
sudo chown -R apache:apache "/var/www/${folderName}/public_html"

clear
echo -e "\e[1mWebsite directory has been created successfully\e[0m"

#Add test file
echo -e "\e[1mCreate test index.php in website directory \e[0m" 

sudo chmod 755 /var/www
printf  "${domainName} <br /> <?php echo 'PHP is OK'?>" > "/var/www/${folderName}/public_html/index.php"

clear
echo -e "\e[1mTest index.php has been created successfully\e[0m"


#Update Apache config if needed
vhostsDir=/etc/httpd/sites-enabled
if [ ! -d "$vhostsDir" ]; then
echo -e "\e[1mUpdate Apache config\e[0m" 

sudo mkdir $vhostsDir
echo '#Load Virtual Hosts' >> /etc/httpd/conf/httpd.conf
echo 'IncludeOptional sites-enabled/*.conf' >> /etc/httpd/conf/httpd.conf

clear
echo -e "\e[1mApache config has been updated successfully\e[0m"
fi

#Create config file for new host
echo -e "\e[1mCreate config file for new host\e[0m"

sudo cat <<EOT >> "/etc/httpd/sites-enabled/${folderName}.conf"
<VirtualHost *:80>
     ServerAdmin admin@${domainName}
     DocumentRoot /var/www/${folderName}/public_html
     ServerName ${domainName}
     ServerAlias www.${domainName}
     ErrorLog logs/${domainName}-error.log
     CustomLog logs/${domainName}-access.log common
</VirtualHost>
EOT

clear
echo -e "\e[1mConfig file has been created successfully\e[0m"



#Restart Apache
echo -e "\e[1mRestart Apache\e[0m"

sudo systemctl restart httpd.service

clear
echo -e "\e[1mApache has been restarted successfully\e[0m"


#Final output
echo '---------------------------------------------'
echo -e "\e[1m$domainName\e[0m has been added successfully"
echo -e "\e[1mhttp://${domainName}/\e[0m"
echo '---------------------------------------------'
echo -e "\e[1mHost Details:\e[0m"
echo 'Host configuration file:'
echo -e "\e[1m/etc/httpd/sites-enabled/${folderName}.conf\e[0m"
echo 'Host document root:'
echo -e "\e[1m/var/www/${folderName}/public_html\e[0m"
echo '---------------------------------------------'
echo 'Read more about virtual hosts and subdomains:'
echo 'https://www.digitalocean.com/community/tutorials/how-to-set-up-apache-virtual-hosts-on-centos-7'
echo 'https://www.digitalocean.com/community/tutorials/how-to-set-up-and-test-dns-subdomains-with-digitalocean-s-dns-panel'
echo '---------------------------------------------'

