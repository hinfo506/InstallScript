#!/bin/bash
################################################################################
# Script for removing Odoo on Ubuntu 18.04
# Author: Dalhyn Yenner Carrillo
#-------------------------------------------------------------------------------
# This script will uninstall Odoo on your Ubuntu 16.04 server. It can install multiple Odoo instances
# in one Ubuntu because of the different xmlrpc_ports
#-------------------------------------------------------------------------------
# Make a new file:
# sudo nano odoo-uninstall.sh
# Place this content in it and then make the file executable:
# sudo chmod +x odoo-uninstall.sh
# Execute the script to uninstall Odoo:
# ./odoo-uninstall
################################################################################

#fixed parameters
#odoo
OE_USER="odoo13"
OE_HOME="/$OE_USER"
OE_HOME_EXT="/$OE_USER/${OE_USER}"

OE_CONFIG="${OE_USER}"

#Just follow these steps
echo -e "\n---- STOP Service ----"
sudo service $OE_CONFIG stop
echo -e "\n---- Service stopped ----"

#Remove config file(s)
echo -e "\n---- Remove conf file ----"
sudo rm -f /etc/${OE_CONFIG}.conf
echo -e "\n---- File removed ----"

#Remove application code
#sudo rm -r /opt/$OE_USER
echo -e "\n---- Remove dir ODOO ----"
cd /
sudo rm -r /$OE_USER
echo -e "\n---- ODOO Dir removed ----"

#Remove startup process
echo -e "\n---- Remove Startup process ----"
sudo update-rc.d -f $OE_CONFIG remove
sudo rm -f /etc/init.d/$OE_CONFIG
echo -e "\n---- Startup process deleted ----"

#Remove logs
echo -e "\n---- Remove log files ----"
sudo rm -r /var/log/$OE_USER
echo -e "\n---- LOG File removed ----"

#Remove databases
sudo service postgresql stop
sudo apt-get remove postgresql -y
sudo apt-get --purge remove postgresql\* -y
sudo rm -r -f /etc/postgresql/
sudo rm -r -f /etc/postgresql-common/
sudo rm -r -f /var/lib/postgresql/

#Delete users and groups
sudo userdel -r postgres
sudo groupdel postgres

echo -e "\n---- Delete User ----"
sudo userdel -r $OE_USER
echo -e "\n---- USER Deleted ----"

#echo -e "\n---- RENAME Sites into NGINX ----"
#sudo cp /etc/nginx/sites-available/default.bak /etc/nginx/sites-available/default
#echo -e "\n---- NGINX Reconfigured ----"