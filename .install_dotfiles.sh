#!/bin/bash

# This scripts install my config files on a new 
# Linux Mint Cinnamon (Ubuntu edition) installation.
# 
# Author: Lucero Alvarado
# Repository: https://github.com/lu0/dotfiles_linuxMint


# Autostart applications
sudo rm -rf ~/.config/autostart
ln -s ~/dotfiles_linuxMint/config/autostart ~/.config/autostart

# Bash style
ln -s ~/dotfiles_linuxMint/.fancy-bash-promt.sh ~/.fancy-bash-promt.sh

rm -rf ~/.bashrc
ln -s ~/dotfiles_linuxMint/config/.bashrc ~/.bashrc

# Theme and icons
ln -s ~/dotfiles_linuxMint/cinnamon/appearance/themes/MintY_RedVariation /usr/share/themes/MintY_RedVariation

cp ~/dotfiles_linuxMint/cinnamon/appearance/themes/MintY_RedVariation.zip /usr/share/themes/MintY_RedVariation.zip
cp ~/dotfiles_linuxMint/cinnamon/appearance/icons/papirus.zip /usr/share/icons/papirus.zip
cp ~/dotfiles_linuxMint/cinnamon/appearance/icons/papirus_redvariation.zip /usr/share/icons/papirus_redvariation.zip

unzip /usr/share/themes/MintY_RedVariation.zip -d /usr/share/themes
unzip /usr/share/icons/papirus.zip -d /usr/share/icons/
unzip /usr/share/icons/papirus_redvariation.zip -d /usr/share/icons/

rm -rf /usr/share/themes/MintY_RedVariation.zip
rm -rf /usr/share/icons/papirus.zip
rm -rf /usr/share/icons/papirus_redvariation.zip


# Startup script (open fave apps)
ln -s ~/dotfiles_linuxMint/.startup_session.sh ~/.startup_session.sh

# Custom launchers (for keybindings)
ln -s ~/dotfiles_linuxMint/mylaunchers ~/.mylaunchers

# Custom keys
# ln -s ~/dotfiles_linuxMint/config/xmodmap_edit.lst ~/.xmodmap_edit.lst
# xmodmap ~/.xmodmap_edit.lst

rm -rf /usr/share/X11/xkb/types/complete
ln -s ~/dotfiles_linuxMint/keymappings/complete /usr/share/X11/xkb/types/complete

rm -rf /usr/share/X11/xkb/types/iso9995
ln -s ~/dotfiles_linuxMint/keymappings/iso9995 /usr/share/X11/xkb/types/iso9995

rm -rf /usr/share/X11/xkb/types/extra
ln -s ~/dotfiles_linuxMint/keymappings/extra /usr/share/X11/xkb/types/extra

rm -rf /usr/share/X11/xkb/symbols/latin
ln -s ~/dotfiles_linuxMint/keymappings/latin /usr/share/X11/xkb/symbols/latin

rm -rf /usr/share/X11/xkb/symbols/latam
ln -s ~/dotfiles_linuxMint/keymappings/latam /usr/share/X11/xkb/symbols/latam

rm -rf /usr/share/X11/xkb/symbols/la
ln -s ~/dotfiles_linuxMint/keymappings/la /usr/share/X11/xkb/symbols/la


# sudo ln -s ~/dotfiles_linuxMint/config/90-custom-kbd.conf /usr/share/X11/xorg.conf.d/90-custom-kbd.conf

# rm -rf ~/.config/nemo/accels
# ln -s ~/dotfiles_linuxMint/config/nemo/accels ~/.config/nemo/accels

# System config
# Export current config with: 
# dconf dump /  > ~/dotfiles_linuxMint/config/dconf.conf
ln -s ~/dotfiles_linuxMint/config/dconf.conf ~/.dconf.conf
dconf load / < ~/.dconf.conf
chmod +775 ~/dotfiles_linuxMint/config/export_dconf.sh

# VS code --------------------------------------------------------------------------------------
rm -rf ~/.config/Code/User/settings.json
ln -s ~/dotfiles_linuxMint/config/vscode/settings_FHD.json ~/.config/Code/User/settings.json
# ln -s ~/dotfiles_linuxMint/config/vscode/settings_HD.json ~/.config/Code/User/settings.json


rm -rf ~/.config/Code/User/keybindings.json
ln -s ~/dotfiles_linuxMint/config/vscode/keybindings.json ~/.config/Code/User/keybindings.json

rm -rf ~/.config/Code/storage.json
ln -s ~/dotfiles_linuxMint/config/vscode/storage.json ~/.config/Code/storage.json

rm -rf ~/.config/Code/rapid_render.json
ln -s ~/dotfiles_linuxMint/config/vscode/rapid_render.json ~/.config/Code/rapid_render.json

rm -rf ~/.config/Code/rapid_render.json
ln -s ~/dotfiles_linuxMint/config/vscode/rapid_render.json ~/.config/Code/rapid_render.json
# ----------------------------------------------------------------------------------------------

rm -rf ~/.config/onedrive/config
ln -s ~/dotfiles_linuxMint/config/onedrive/config ~/.config/onedrive/config

rm -rf ~/.config/mintmenu/-snap-code-29-meta-gui-com.visualstudio.code.png
ln -s ~/dotfiles_linuxMint/config/-snap-code-29-meta-gui-com.visualstudio.code.png ~/.config/mintmenu/-snap-code-29-meta-gui-com.visualstudio.code.png

# Nemo keybindings
rm -rf ~/.gnome2
ln -s ~/dotfiles_linuxMint/gnome2 ~/.gnome2

# Install VSCode extensions
~/dotfiles_linuxMint/config/vscode/install_extensions.sh
