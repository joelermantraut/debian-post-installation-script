#!/bin/bash

echo "Installing SDDM and dependencies..."
apt install -y --no-install-recommends sddm qml-module-qtquick-layouts qml-module-qtquick-controls2 libqt6svg6

echo "Downloading Catppuccin SDDM theme..."
wget --retry-connrefused --show-progress https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-mocha.zip -P /usr/share/sddm/themes/ || echo "Failed to download Catppuccin theme."

echo -e "[Theme]\nCurrent=catppuccin-mocha" >/etc/sddm.conf
