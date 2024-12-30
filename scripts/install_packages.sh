#!/bin/bash

echo "Installing APT packages..."
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

  # SYSTEM
  "software-properties-common"
  "apt-transport-https"
  "lxtask"
  "curl"
  "snapd"
  "zsh"
  "zplug"
  "caffeine"
  "dunst"
  "flameshot"
  "flatpak"
  "gdebi"
  "i3"
  "pass"
  "polybar"
  "rofi"
  "scrot"
  "speedcrunch"
  "xclip"
  "xdotool"
  "zenity"
  "zoxide"
  "libpcre3-dev" # Needed dependency for i3lock-color
  "libxcb-dpms0-dev"
  "psmisc"
  "i3lock"
  "pipx"

  # FILE
  "tar"
  "xarchiver"
  "feh"
  "thunar"
  "thunar-archive-plugin"
  "fonts-noto-color-emoji"
  "fzf"
  "gparted"
  "trash-cli"
  "udiskie"
  "stow"

  # MEDIA
  "imagemagick"
  "obs-studio"
  "pavucontrol"
  "playerctl"
  "vlc"
  "gpg"
)

for pkg en "${packages[@]}"; do
  echo "Installing $pkg..."
  apt install -y "$pkg" || echo "Failed to install $pkg."
done
