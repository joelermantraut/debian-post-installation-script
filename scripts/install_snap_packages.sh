#!/bin/bash

echo "Installing Snap packages..."
snap_packages=(
  "core"
  "alacritty"
  "wps-office"
)

for pkg in "${snap_packages[@]}"; do
  echo "Installing $pkg..."
  snap install "$pkg" || echo "Failed to install $pkg."
done
