#!/bin/bash

echo "Installing utilities..."
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip -P /usr/bin/ || echo "Failed to download greenclip."
chmod +x /usr/bin/greenclip

echo "Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf || echo "Failed to clone fzf."
~/.fzf/install --all

echo -e "\nCompiling and installing i3lock-color\n"
apt install autoconf pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
./install-i3lock-color.sh

echo -e "\nInstalling betterlockscreen\n"
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | bash -s user

echo -e "\nInstalling Nerd Fonts (this may take a while)\n"
git clone https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#option-7-install-script
cd nerd-fonts
./install.sh

echo -e "\nCompiling and installing picom\n"
apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson
git clone https://github.com/fdev31/picom/
cd picom
git submodule update --init --recursive
meson setup --buildtype=release . build
ninja -C build
mkdir ~/.local/bin
cp build/src/picom ~/.local/bin/picom
