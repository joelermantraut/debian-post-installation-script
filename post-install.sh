#!/bin/bash

# Check if script is running as root
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root."
  exit 1
fi

# Install KDE Plasma
echo "Installing KDE Plasma..."
apt update
apt install kde-plasma-desktop -y

# Needed dependencies
apt install wget gpg software-properties-common apt-transport-https

# Installing Visual Studio Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg

sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

apt update
apt install code

# Installing Neovim
wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod +x ./nvim.appimage 
mv nvim.appimage /usr/local/bin/nvim
rm nvim.appimage

# Installing Cargo (installs rust and cargo with it)
curl https://sh.rustup.rs -sSf | sh

# Cargo apps
cargo install alacritty

# More software
apt install chromium
apt install git
apt install python3
apt install python3-pip
apt install htop
apt install curl
apt install snapd
apt install ping
apt install ifconfig
apt install openssh-server
apt install tar
apt install gedit
apt install fonts-anonymous-pro

# Configure KDE Plasma as default desktop environment
echo "Configuring KDE Plasma as the default desktop environment..."
echo "/usr/bin/startkde" > /etc/X11/xinit/xinitrc

# Install additional programs
# (Here you can add instructions to install other desired programs)

# End of the script
echo "Installation and configuration completed."
