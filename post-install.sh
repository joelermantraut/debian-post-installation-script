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

# Configure KDE Plasma as default desktop environment
echo "Configuring KDE Plasma as the default desktop environment..."
echo "/usr/bin/startkde" > /etc/X11/xinit/xinitrc

# Software
packages=(
    "chromium"
    "git"
    "python3"
    "python3-pip"
    "htop"
    "curl"
    "snapd"
    "ping"
    "ifconfig"
    "openssh-server"
    "tar"
    "gedit"
    "fonts-anonymous-pro"
)

for pkg in "${packages[@]}"
do
    sudo apt install -y "$pkg"
done

# Install additional programs

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

# End of the script
echo "Installation and configuration completed."
