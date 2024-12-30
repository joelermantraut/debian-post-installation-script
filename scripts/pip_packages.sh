#!/bin/bash

echo "Installing Pipx packages..."
pipx_packages=(
  pyright
  ruff
)

for pkg in "${pipx_packages[@]}"; do
  echo "Installing $pkg..."
  pipx install "$pkg" || echo "Failed to install $pkg."
done
