# debian-post-installation-script

Post install script, for Debian 12 Bookworm, setted up for me.

## Specs
 - System is oriented to [Catppuccin Mocha theme](https://catppuccin.com/palette).
 - My default windows manager is [i3](https://i3wm.org/).
 - There is another windows manager installed, [Xfce](https://www.xfce.org/), which is a floating WM. I use it to fallback when something fails in i3.
 - The bar for i3 is [Polybar](https://github.com/polybar/polybar).
 - The main terminal is [Alacritty](https://github.com/alacritty/alacritty). There is also x-terminal-emulator, from XfCE.
 - The shell is [Zsh](https://www.zsh.org/) with [Oh-My-Zsh](https://ohmyz.sh/).
 - The text editors are [Neovim](https://neovim.io/) and [Visual Studio Code](https://code.visualstudio.com/). For minor task there are also [nano](https://www.nano-editor.org/) and [mousepad](https://github.com/codebrainz/mousepad).
 - The main app launcher is [Rofi](https://github.com/davatorium/rofi).
 - The default web browser is [Firefox](https://www.mozilla.org/en-US/firefox/new/?redirect_source=firefox-com).
 - The default file manager is [Thunar](https://docs.xfce.org/xfce/thunar/start).
 - The notification daemon is [Dunst](https://github.com/dunst-project/dunst). There is also a notification manager with Rofi.
 - Clipboard manager is [greenclip](https://github.com/erebe/greenclip).
 - Session manager is [SDDM](https://github.com/sddm/sddm).
 - There are scripts developed for Rofi, Dunst and some general utilities.
 - There are config files for other apps.

## How to set this

1. It recommended to run installer, and install with no desktop environment. If done in this way,
system will show a TTY on boot. Anyway, enter in a TTY before login. There, log in **AS ROOT** and run:
```
usermod -a -G sudo user
apt install sudo git
```
Replace user with your username.

2. Type `exit`, and log in **WITH YOUR USER**.

3. Download script, you can use `wget` command like this:
```
git clone https://github.com/joelermantraut/debian-post-installation-script.git
cd debian-post-installation-script
```
4. Give script execution permissions:
```
chmod +x *.sh
```
5. Run script:
```
sudo ./install.sh
```
6. Pay attention to the output, and follow the instructions. Some of the task may require intervention.

## Sources

### System
 - https://gcore-com.translate.goog/learning/how-to-install-xfce-on-debian/?_x_tr_sl=en&_x_tr_tl=es&_x_tr_hl=es&_x_tr_pto=tc
 - https://www.reddit.com/r/kde/comments/cw4k5g/installing_sddm_without_kdeplasma/
 - https://doc.rust-lang.org/cargo/getting-started/installation.html
 - https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#option-7-install-script

### Apps
 - https://en.ubunlog.com/whatsdesk-for-whatsapp/
 - https://yazi-rs.github.io/docs/installation/#cargo
 - https://wiki.debian.org/Zsh
 - https://ohmyz.sh/#install
 - https://gitlab.com/Nmoleo/i3-volume-brightness-indicator
 - https://github.com/erebe/greenclip
 - https://github.com/junegunn/fzf
 - https://github.com/Raymo111/i3lock-color
 - https://github.com/betterlockscreen/betterlockscreen
 - https://github.com/fdev31/picom/tree/next
 - https://www.linuxtechi.com/how-to-install-virtualbox-on-debian/
 - https://github.com/scopatz/nanorc
 - https://github.com/easymodo/qimgv/

### Catppuccin
 - https://github.com/catppuccin/sddm?tab=readme-ov-file#usage
 - https://github.com/catppuccin/nvim
 - https://github.com/catppuccin/yazi/blob/main/themes/mocha/catppuccin-mocha-teal.toml
 - https://github.com/catppuccin/dunst/blob/main/themes/mocha.conf
 - http://www.lazyvim.org/configuration

### To put system online
 - https://stackoverflow.com/questions/41007182/listing-all-user-installed-packages-in-debian
 - https://askubuntu.com/questions/303497/how-to-add-an-entry-to-fstab
 - https://github.com/avtzis/awesome-linux-ricing?tab=readme-ov-file

### GNU Stow
 - https://www.youtube.com/watch?v=y6XCebnB9gs
 - https://apiumhub.com/tech-blog-barcelona/managing-dotfiles-with-stow/
 - https://www.gnu.org/software/stow/manual/html_node/Resource-Files.html#Resource-Files

### KMonad
 - https://codebenchers.com/blog/kmonad-on-ubuntu-program-your-keyboard
 - https://stackoverflow.com/questions/11939255/writing-to-dev-uinput-on-ubuntu-12-04
 - https://github.com/david-janssen/kmonad/blob/master/doc/faq.md#q-how-do-i-get-uinput-permissions

### VirtualBox
 - https://askubuntu.com/questions/761901/how-to-switch-to-a-tty-in-virtual-box-vm

### Other
 - https://github.com/yshui/picom/issues/305
 - https://github.com/i3/i3/issues/2324


## Comments

#### How are dotfiles stored?
Initially I used this [Atlassian recommendation](https://www.atlassian.com/git/tutorials/dotfiles), but as most people, I found it a bit confusing. So, I changed to [GNU Stow](https://www.gnu.org/software/stow/).
