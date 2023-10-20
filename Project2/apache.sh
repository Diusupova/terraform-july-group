#!/bin/bash

#!/bin/bash
# Update the package repository
sudo apt-get update -y
# Install required packages
sudo apt-get install -y autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php libgd-dev libmcrypt-dev libssl-dev bc gawk dc build-essential snmp libnet-snmp-perl gettext
# Create a Nagios user and group
sudo useradd nagios
sudo groupadd nagcmd
sudo usermod -a -G nagcmd nagios
# Download Nagios Core and Plugins
cd /tmp
wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz
wget https://nagios-plugins.org/download/nagios-plugins-2.3.3.tar.gz
# Extract the downloaded files
tar -zxvf nagios-4.4.6.tar.gz
tar -zxvf nagios-plugins-2.3.3.tar.gz
# Compile and install Nagios Core
cd nagios-4.4.6
./configure --with-command-group=nagcmd
make all
sudo make install
sudo make install-init
sudo make install-commandmode
sudo make install-config
sudo make install-webconf
sudo a2enmod rewrite
sudo a2enmod cgi
# Set the Nagios admin password
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
# Compile and install Nagios Plugins
cd /tmp/nagios-plugins-2.3.3
./configure --with-nagios-user=nagios --with-nagios-group=nagios
make
sudo make install
# Start the Apache web server and Nagios service
sudo systemctl restart apache2
sudo systemctl enable nagios
sudo systemctl start nagios
# Open necessary firewall ports (80 for Apache, and 5666 for NRPE)
sudo ufw allow 80/tcp
sudo ufw allow 5666/tcp
# Clean up downloaded files
rm -rf /tmp/nagios*