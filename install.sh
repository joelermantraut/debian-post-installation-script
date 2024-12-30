#!/bin/bash

# Verificar permisos de root
if [ "$(id -u)" != "0" ]; then
  echo -e "This script must be run as root."
  exit 1
fi

LOG_FILE="errors.log"
exec 2>"$LOG_FILE" # Redirigir errores a errors.log

echo "Starting installation process..."

# Ejecutar scripts divididos
scripts=(
  "scripts/system_update.sh"
  "scripts/install_sddm.sh"
  "scripts/install_packages.sh"
  "scripts/install_snap_packages.sh"
  "scripts/cargo_packages.sh"
  "scripts/install_utilities.sh"
  "scripts/install_virtualbox.sh"
  "scripts/setup_zsh.sh"
  "scripts/set_dotfiles.sh"
)

for script in "${scripts[@]}"; do
  echo "Running $script..."
  bash "$script" || echo "Error executing $script. Check $LOG_FILE for details."
done

echo -e "\nInstallation and setup completed. Check $LOG_FILE for any errors."
