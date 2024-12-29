#!/bin/bash

echo "Installing VirtualBox..."
apt install gnupg2 lsb-release -y
curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/vbox.gpg
echo -e "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | tee /etc/apt/sources.list.d/virtualbox.list
apt update && apt install -y virtualbox-7.0 || echo "Failed to install VirtualBox."
