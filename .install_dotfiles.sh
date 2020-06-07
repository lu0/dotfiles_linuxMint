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

rm -rf /etc/inputrc
ln -s ~/dotfiles_linuxMint/config/inputrc /etc/inputrc

# Fonts
sudo cp -r fonts/source-code-pro/OTF /usr/share/fonts/opentype/source-code-pro
sudo cp -r fonts/karla /usr/share/fonts/opentype/karla

# Theme and icons
cp ~/dotfiles_linuxMint/cinnamon/appearance/themes/MintY_RedVariation/MintY_RedVariation.zip /usr/share/themes/MintY_RedVariation.zip
cp ~/dotfiles_linuxMint/cinnamon/appearance/icons/papirus.zip /usr/share/icons/papirus.zip
cp ~/dotfiles_linuxMint/cinnamon/appearance/icons/papirus_redvariation.zip /usr/share/icons/papirus_redvariation.zip

unzip /usr/share/themes/MintY_RedVariation.zip -d /usr/share/themes
unzip /usr/share/icons/papirus.zip -d /usr/share/icons/
unzip /usr/share/icons/papirus_redvariation.zip -d /usr/share/icons/

rm -rf /usr/share/themes/MintY_RedVariation.zip
rm -rf /usr/share/icons/papirus.zip
rm -rf /usr/share/icons/papirus_redvariation.zip

rm /usr/share/themes/MintY_RedVariation/cinnamon/cinnamon.css
ln -s ~/dotfiles_linuxMint/cinnamon/appearance/themes/MintY_RedVariation/cinnamon.css /usr/share/themes/MintY_RedVariation/cinnamon/cinnamon.css

rm /usr/share/themes/MintY_RedVariation/gtk-3.0/gtk.css
ln -s ~/dotfiles_linuxMint/cinnamon/appearance/themes/MintY_RedVariation/gtk.css /usr/share/themes/MintY_RedVariation/gtk-3.0/gtk.css

rm /usr/share/themes/MintY_RedVariation/metacity-1/metacity-theme-3.xml
ln -s ~/dotfiles_linuxMint/cinnamon/appearance/themes/MintY_RedVariation/metacity-theme-3.xml /usr/share/themes/MintY_RedVariation/metacity-1/metacity-theme-3.xml

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

# Backups 
ln -s ~/dotfiles_linuxMint/mint-gui-backups ~/Documents/Backups

# sudo ln -s ~/dotfiles_linuxMint/config/90-custom-kbd.conf /usr/share/X11/xorg.conf.d/90-custom-kbd.conf

# rm -rf ~/.config/nemo/accels
# ln -s ~/dotfiles_linuxMint/config/nemo/accels ~/.config/nemo/accels

# System config
# Export current config with: 
# dconf dump /  > ~/dotfiles_linuxMint/config/dconf.conf
ln -s ~/dotfiles_linuxMint/config/dconf.conf ~/.dconf.conf
dconf load / < ~/.dconf.conf
chmod +775 ~/dotfiles_linuxMint/config/export_dconf.sh

# ----------------------------------------------------------------------------------------------

rm -rf ~/.config/onedrive/config
ln -s ~/dotfiles_linuxMint/config/onedrive/config ~/.config/onedrive/config

# Nemo keybindings
rm -rf ~/.gnome2
ln -s ~/dotfiles_linuxMint/gnome2 ~/.gnome2

# Fan control (thinkpad x1y3)
sudo cp ~/dotfiles_linuxMint/fan-control/thinkfan_acpi.conf /etc/modprobe.d/
modprobe -r thinkpad_acpi && modprobe thinkpad_acpi
systemctl enable thinkfan