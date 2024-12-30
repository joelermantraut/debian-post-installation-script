echo -e "\nDownloading dotfiles...\n"
git clone https://github.com/joelermantraut/dotfiles.git
cd ~/dotfiles && stow .
