#!/bin/bash

# Check if script is running as root
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root."
  exit 1
fi

apt upgrade -y

# Install KDE Plasma
echo "\nInstalling XFCE...\n"
apt update
apt install -y xfce4

echo "\nXFCE Installed. Installing SDDM...\n"

apt install --no-install-recommends sddm

echo "\nSDDM Installed. Installing user packages...\n"

# Software
packages=(
  "firefox"
  "git"
  "python3"
  "python3-pip"
  "lxtask"
  "curl"
  "snapd"
  "ping"
  "ifconfig"
  "openssh-server"
  "tar"
  "xarchiver"
  "nano"
  "gcc"
  "zsh"
  "zplug"
  "bat"
  "caffeine"
  "cmake"
  # "code"
  "dunst"
  "feh"
  "flameshot"
  "flatpak"
  "fonts-noto-color-emoji"
  "fzf"
  "gdebi"
  "grep"
  "i3"
  "imagemagick"
  "meson"
  "ninja"
  "obs-studio"
  "pass"
  "pavucontrol"
  "playerctl"
  "polybar"
  "redshift"
  "ripgrep"
  "rofi"
  "scrot"
  "speedcrunch"
  "thunar"
  "thunar-archive-plugin"
  "trashcli"
  "udiskie"
  "xclip"
  "xdotool"
  "zenity"
  "zoxide"
  "wget"
  "gpg"
  "software-properties-common"
  "apt-transport-https"
  "psmisc"
  "pass"
  "i3lock"
  "bc"
  "libpcre3-dev" # Needed dependency for i3lock-color
  "libxcb-dpms0-dev"
)

for pkg in "${packages[@]}"; do
  echo "Installing $pkg with apt\n"
  apt install -y "$pkg"
done

# Install Snap packages

echo "\nApt packages installed. Installing Snap packages...\n"

packages=(
  "core"
  "wps-office"
  "alacritty"
  "pyright"
  "ruff"
  "whatsdesk"
)

for pkg in "${packages[@]}"; do
  echo "Installing $pkg with Snap\n"
  snap install "$pkg"
done

echo "\nSnap packages installed. Installing Cargo...\n"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update

echo "\nInstalling Cargo packages...\n"

cargo install --locked yazi-fm yazi-cli

echo "\nCargo packages installed. Installing Visual Studio Code...\n"

# Installing Visual Studio Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg

sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

apt update
apt install -y code

echo "\nInstalling Neovim...\n"

# Installing Neovim

echo "\nInstalling Anydesk...\n"

# Install Anydesk
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
echo "deb http://deb.anydesk.com/ all main" >/etc/apt/sources.list.d/anydesk-stable.list
apt update
apt install -y anydesk

# Install utilities
echo "\nInstalling utilities...\n"

echo "\nInstalling greenclip\n"
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip -P /usr/bin/
echo "\nInstalling fzf\n"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

echo "\nCompiling and installing i3lock-color\n"
apt install autoconf pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
./install-i3lock-color.sh

echo "\nInstalling betterlockscreen\n"
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | bash -s user

echo "\nInstalling Nerd Fonts (this may take a while)\n"
git clone https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#option-7-install-script
cd nerd-fonts
./install.sh

echo "\nCompiling and installing picom\n"
libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson
git clone https://github.com/fdev31/picom/tree/next
cd picom
git submodule update --init --recursive
meson setup --buildtype=release . build
ninja -C build
cp build/picom ~/.local/bin/picom

echo "\nAll utilities installed.\n"

echo "\nInstalling VirtualBox\n"

apt install gnupg2 lsb-release -y
curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/vbox.gpg
curl -fsSL https://www.virtualbox.org/download/oracle_vbox.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/oracle_vbox.gpg
echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | tee /etc/apt/sources.list.d/virtualbox.list
apt update
apt install linux-headers-$(uname -r) dkms -y
apt install virtualbox-7.0 -y

# Install oh-my-zsh
echo "\nInstalling Oh-My-Zsh...\n"
cd $HOME
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install ZSH plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Making zsh default shell
chsh -s /bin/zsh

# Reloading zsh
zsh

# Setting up

echo ".cfg" >>.gitignore
git clone --bare https://github.com/joelermantraut/debian-dotfiles.git $HOME/.cfg

# End of the script
echo "\nInstallation and setting up completed.\n"
