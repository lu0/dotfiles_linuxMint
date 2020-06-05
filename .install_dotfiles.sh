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

rm /usr/share/themes/MintY_RedVariation/metacity-1/metacity-theme-2.xml
ln -s ~/dotfiles_linuxMint/cinnamon/appearance/themes/MintY_RedVariation/metacity-theme-2.xml /usr/share/themes/MintY_RedVariation/metacity-1/metacity-theme-2.xml

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

# VS code --------------------------------------------------------------------------------------
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install code # or code-insiders


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

# Fan control (thinkpad x1y3)
sudo cp ~/dotfiles_linuxMint/fan-control/thinkfan_acpi.conf /etc/modprobe.d/
modprobe -r thinkpad_acpi && modprobe thinkpad_acpi
systemctl enable thinkfan