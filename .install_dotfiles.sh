#!/bin/bash

# This scripts install my config files on a new 
# Linux Mint Cinnamon (Ubuntu edition) installation.
# 
# Author: Lucero Alvarado
# Repository: https://github.com/lu0/dotfiles_linuxMint


# Startup apps
rm -rf ~/.config/autostart
ln -sr config/autostart ~/.config/autostart

# Bash style, aliases and keymappings
ln -sr bash/fancy-bash.sh ~/.fancy-bash.sh
rm -rf ~/.bashrc
ln -sr bash/bashrc ~/.bashrc
sudo rm -rf /etc/inputrc
sudo ln -sr bash/inputrc /etc/inputrc
ln -sr keymappings/keymappings-X1Y3.sh ~/.keymappings-X1Y3.sh

# Fonts
sudo cp -r fonts/source-code-pro/OTF /usr/share/fonts/opentype/source-code-pro
sudo cp -r fonts/karla /usr/share/fonts/opentype/karla
sudo cp -r fonts/webly-sleek /usr/share/fonts/truetype/webly-sleek-ui

# Theme and icons
cd cinnamon/appearance/
sudo unzip themes/MintY_RedVariation/MintY_RedVariation.zip -d /usr/share/themes
sudo unzip themes/Minimal_RedAccents/Minimal_RedAccents.zip -d /usr/share/themes
sudo unzip icons/papirus.zip -d /usr/share/icons/
sudo unzip icons/papirus_redvariation.zip -d /usr/share/icons/

sudo rm /usr/share/themes/MintY_RedVariation/cinnamon/cinnamon.css
sudo rm /usr/share/themes/MintY_RedVariation/gtk-3.0/gtk.css
sudo rm /usr/share/themes/MintY_RedVariation/metacity-1/metacity-theme-3.xml
sudo ln -sr themes/MintY_RedVariation/cinnamon.css /usr/share/themes/MintY_RedVariation/cinnamon/cinnamon.css
sudo ln -sr themes/MintY_RedVariation/gtk.css /usr/share/themes/MintY_RedVariation/gtk-3.0/gtk.css
sudo ln -sr themes/MintY_RedVariation/metacity-theme-3.xml /usr/share/themes/MintY_RedVariation/metacity-1/metacity-theme-3.xml

sudo rm /usr/share/themes/Minimal_RedAccents/cinnamon/cinnamon.css
sudo rm /usr/share/themes/Minimal_RedAccents/gtk-3.0/gtk.css
sudo rm /usr/share/themes/Minimal_RedAccents/metacity-1/metacity-theme-3.xml
sudo ln -sr themes/Minimal_RedAccents/cinnamon.css /usr/share/themes/Minimal_RedAccents/cinnamon/cinnamon.css
sudo ln -sr themes/Minimal_RedAccents/gtk.css /usr/share/themes/Minimal_RedAccents/gtk-3.0/gtk.css
sudo ln -sr themes/Minimal_RedAccents/metacity-theme-3.xml /usr/share/themes/Minimal_RedAccents/metacity-1/metacity-theme-3.xml

# Blur wallpaper
cd .. 
sudo ln -sr wallpaper.jpg /usr/share/backgrounds/wallpaper.jpg
sudo ln -sr wallpaper-blur.png /usr/share/backgrounds/wallpaper-blur.png
sudo ln -sr mintLogo_alt.png ~/.face.icon
feh --bg-fill "/usr/share/backgrounds/wallpaper.jpg"
ln -sr blur-wallpaper/feh-blur ~/.feh-blur
# cd blur-wallpaper
~/.feh-blur --blur 10 --darken 10 -d

cd ../../

# Startup script (open fave apps)
ln -sr homedir/startup_session.sh ~/.startup_session.sh

# Custom launchers (for keybindings)
ln -sr homedir/mylaunchers ~/.mylaunchers

# Custom media keys
ln -sr homedir/mediaKeys_ThinkPadX1Y3.lst ~/.mediaKeys_ThinkPadX1Y3.lst

# Get rid of shadows in window borders
sudo rm /etc/environment
sudo ln -sr config/environment /etc/environment

# ln -sr config/xmodmap_edit.lst ~/.xmodmap_edit.lst
# xmodmap ~/.xmodmap_edit.lst

# rm -rf /usr/share/X11/xkb/types/complete
# ln -sr keymappings/complete /usr/share/X11/xkb/types/complete

# rm -rf /usr/share/X11/xkb/types/iso9995
# ln -sr keymappings/iso9995 /usr/share/X11/xkb/types/iso9995

# rm -rf /usr/share/X11/xkb/types/extra
# ln -sr keymappings/extra /usr/share/X11/xkb/types/extra

# rm -rf /usr/share/X11/xkb/symbols/latin
# ln -sr keymappings/latin /usr/share/X11/xkb/symbols/latin

# rm -rf /usr/share/X11/xkb/symbols/latam
# ln -sr keymappings/latam /usr/share/X11/xkb/symbols/latam

# rm -rf /usr/share/X11/xkb/symbols/la
# ln -sr keymappings/la /usr/share/X11/xkb/symbols/la
# sudo ln -sr config/90-custom-kbd.conf /usr/share/X11/xorg.conf.d/90-custom-kbd.conf

# System config
# Export current config with: 
# dconf dump /  > ~/dotfiles_linuxMint/config/dconf.conf
# ln -sr dconf-files/dconf.conf ~/.dconf.conf
# dconf load / < ~/.dconf.conf
./cinnamon/install-spices.sh
dconf load / < ~/dotfiles_linuxMint/dconf-files/desktop-keybindings.conf
dconf load /org/gnome/terminal/ < ~/dotfiles_linuxMint/dconf-files/gnome-terminal.conf
dconf load / < ~/dotfiles_linuxMint/dconf-files/miscellaneous.conf
dconf load / < ~/dotfiles_linuxMint/dconf-files/nemo-fileman.conf
dconf load /org/cinnamon/ < ~/dotfiles_linuxMint/dconf-files/system-sounds.conf

# Opacify windows
mkdir -p ~/.local/bin
ln -sr cinnamon/opacify_windows.sh ~/.local/bin
# apt install xdotool wmctrl

# Github script
ln -sr homedir/git-create-repo.sh ~/.git-create-repo.sh
 
# ----------------------------------------------------------------------------------------------

# rm -rf ~/.config/onedrive/config
# ln -sr config/onedrive/config ~/.config/onedrive/config

# Nemo keybindings
rm -rf ~/.gnome2
ln -sr homedir/gnome2 ~/.gnome2

# Fan control (thinkpad x1y3)
# sudo cp -r fan-control/thinkfan_acpi.conf /etc/modprobe.d/
# modprobe -r thinkpad_acpi && modprobe thinkpad_acpi
# systemctl enable thinkfan