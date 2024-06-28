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
    "alacritty"
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
    "gcc"
    "npm"
    "nodejs"
    "zsh"
    "zplug"
)

for pkg in "${packages[@]}"
do
    sudo apt install -y "$pkg"
done

# Install additional programs

# Needed dependencies
apt install -y wget gpg software-properties-common apt-transport-https

# Installing Visual Studio Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg

sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

apt update
apt install -y code

# Installing Neovim
wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod +x ./nvim.appimage
mv nvim.appimage /usr/local/bin/nvim
rm nvim.appimage
# Setting up Neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# Install Neovim Plugins
nvim +PlugInstall +qall
nvim +"CocInstall coc-sh coc-clangd coc-css coc-go coc-html coc-tsserver coc-json coc-jedi" +qall
nvim +"CocInstall clangd.install" +qall
nvim +"CocInstall coc-prettier coc-pairs" +qall

# Install Sublime Text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text
sudo apt-get install apt-transport-https

# Install Anydesk
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list
sudo apt update
apt install -y anydesk

# Install Snap core
sudo snap install core

# Install WPS Office Suite
sudo snap install wps-office

# Install oh-my-zsh
echo "\nInstalling Oh-My-Zsh\n"
cd $HOME
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install ZSH plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

# Setting up

git clone https://github.com/joelermantraut/dotfiles.git
cd dotfiles
yes | rm -r .git
yes | rm .gitignore README.md
cd ..
yes | cp -r dotfiles/. $HOME

# Making zsh default shell
chsh -s /bin/zsh

# End of the script
echo "Installation and configuration completed."
