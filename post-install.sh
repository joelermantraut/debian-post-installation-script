#!/bin/bash

# Check if script is running as root
if [ "$(id -u)" != "0" ]; then
  echo -e "This script must be run as root."
  exit 1
fi

apt update
apt upgrade -y

apt install -y --no-install-recommends sddm qml-module-qtquick-layouts qml-module-qtquick-controls2 libqt6svg6
wget https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-mocha.zip -P /usr/share/sddm/themes/
echo -e "[Theme]\nCurrent=catppuccin-mocha" >/etc/sddm.conf

echo -e "\nSDDM Installed. Installing user packages...\n"

# Software
packages=(
  # WEB
  "firefox-esr"
  "openssh-server"

  # DEV
  "git"
  "python3"
  "python3-pip"
  "nano"
  "gcc"
  "bat"
  "cmake"
  "grep"
  "meson"
  "ninja-build"
  "arduino"
  "nodejs"
  "npm"
  "bpython"

  # SYSTEM
  "software-properties-common"
  "apt-transport-https"
  "build-essential"
  "lxtask"
  "curl"
  "snapd"
  "caffeine"
  "flatpak"
  "gdebi"
  "psmisc"
  "pipx"
  "unzip"

  # GUI
  "dunst"
  "flameshot"
  "i3"
  "i3lock"
  "libpcre3-dev" # Needed dependency for i3lock-color
  "libxcb-dpms0-dev"
  "polybar"
  "rofi"
  "scrot"
  "speedcrunch"
  "zenity"

  # SHELL
  "zsh"
  "zplug"
  "pass"
  "xclip"
  "xdotool"
  "zoxide"

  # FILE
  "tar"
  "xarchiver"
  "feh"
  "thunar"
  "thunar-archive-plugin"
  "fonts-noto-color-emoji"
  "fzf"
  "gparted"
  "trashcli"
  "udiskie"
  "stow"

  # MEDIA
  "imagemagick"
  "obs-studio"
  "pavucontrol"
  "playerctl"
  "vlc"
  "gpg"
  "qimgv"
)

for pkg in "${packages[@]}"; do
  echo -e "Installing $pkg with apt\n"
  apt install -y "$pkg"
done

# Install Snap packages

echo -e "\nApt packages installed. Installing Snap packages...\n"

packages=(
  "core"
  "wps-office"
  "alacritty"
  "whatsdesk"
)

for pkg in "${packages[@]}"; do
  echo -e "Installing $pkg with Snap\n"
  snap install "$pkg"
done

echo -e "\nSnap packages installed. Installing Cargo...\n"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# rustup update

echo -e "\nInstalling Cargo packages...\n"

cargo install --locked yazi-fm yazi-cli

echo -e "\nCargo packages installed. Installing Visual Studio Code...\n"

cd ~
# Setup env on home

# Installing Visual Studio Code
apt install -y libx11-xcb1 libasound2 # dependencies
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg

sh -c 'echo -e "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

apt update
apt install -y code

echo -e "\nInstalling Neovim...\n"
sudo apt install -y gettext
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
git checkout stable
sudo make install

echo -e "\nInstalling LazyVim...\n"
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

echo -e "\nInstalling Anydesk...\n"

# Install Anydesk
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
echo -e "deb http://deb.anydesk.com/ all main" >/etc/apt/sources.list.d/anydesk-stable.list
apt update
apt install -y anydesk

# Install utilities
echo -e "\nInstalling utilities...\n"

echo -e "\nInstalling greenclip\n"
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip -P /usr/bin/

echo -e "\nInstalling fzf\n"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

echo -e "\nCompiling and installing i3lock-color\n"
apt install autoconf pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
./install-i3lock-color.sh

echo -e "\nInstalling betterlockscreen\n"
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | bash -s user

# echo -e "\nInstalling Nerd Fonts (this may take a while)\n"
# git clone https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#option-7-install-script
# cd nerd-fonts
# ./install.sh

echo -e "\nCompiling and installing picom\n"
apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson
git clone https://github.com/fdev31/picom/
cd picom
git submodule update --init --recursive
meson setup --buildtype=release . build
ninja -C build
mkdir ~/.local/bin
cp build/src/picom ~/.local/bin/picom

echo -e "\nAll utilities installed.\n"

echo -e "\nInstalling VirtualBox\n"

apt install -y gnupg2 lsb-release -y
curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/vbox.gpg
curl -fsSL https://www.virtualbox.org/download/oracle_vbox.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/oracle_vbox.gpg
echo -e "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | tee /etc/apt/sources.list.d/virtualbox.list
apt update
apt install -y linux-headers-$(uname -r) dkms -y
apt install -y virtualbox-7.0 -y

# Install oh-my-zsh
echo -e "\nInstalling Oh-My-Zsh...\n"
cd $HOME
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo -e "\nInstalling Zsh Plugins..\n"
# Install ZSH plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Setting up

echo -e "\nDownloading dotfiles...\n"
git clone https://github.com/joelermantraut/dotfiles.git
cd ~/dotfiles && stow .

# End of the script
echo -e "\nInstallation and setting up completed.\n"
echo -e "Pending:\n"
echo -e "Making zsh default shell: chsh -s /bin/zsh\n"
