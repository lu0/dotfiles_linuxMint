#!/bin/bash

# This scripts install my config files on a new 
# Linux Mint Cinnamon (Ubuntu edition) installation.
# 
# Author: Lucero Alvarado
# Repository: https://github.com/lu0/dotfiles_linuxMint

# Install Packages
# source scripts/install-packages.sh

# Startup apps ----------------------------------------------------------------
# rm -rf ~/.config/autostart
# ln -sr config/autostart ~/.config/autostart

# Startup script (open fave apps)
# ln -sr homedir/startup_session.sh ~/.startup_session.sh

# Bash style and aliases  -----------------------------------------------------
# ln -sr bash/fancy-bash.sh ~/.fancy-bash.sh
# rm -rf ~/.bashrc
# ln -sr bash/bashrc ~/.bashrc
# ln -sr homedir/git-create-repo.sh ~/.git-create-repo.sh     # Push New Repo to Github 
# sudo rm -rf /etc/inputrc
# sudo ln -sr bash/inputrc /etc/inputrc

# Custom Keymappings  ---------------------------------------------------------
## ln -sr homedir/mediaKeys_ThinkPadX1Y3.lst ~/.mediaKeys_ThinkPadX1Y3.lst
## ln -sr keymappings/keymappings-X1Y3.sh ~/.keymappings-X1Y3.sh

# Cinnamon appearance ------------------------------------------------------
# Disable shadows in window borders
# sudo rm /etc/environment
# sudo ln -sr config/environment /etc/environment

# Blur wallpaper when desktop is "busy"
# cd cinnamon/blur-wallpaper
# sudo ln -sr wallpaper.jpg /usr/share/backgrounds/wallpaper.jpg
# sudo ln -sr wallpaper-blur.png /usr/share/backgrounds/wallpaper-blur.png
# sudo ln -sr mintLogo_alt.png ~/.face.icon
# feh --bg-fill "/usr/share/backgrounds/wallpaper.jpg"
# ln -sr blur-wallpaper/feh-blur ~/.feh-blur
# ~/.feh-blur --blur 10 --darken 10 -d
# cd ../../

# Transparency of unfocused windows
# mkdir -p ~/.local/bin
# ln -sr cinnamon/opacify-windows.sh ~/.local/bin

# Icons and Themes
# cd cinnamon/appearance/
# ./icons/install-papirus.sh 
# papirus-folders --color yaru --theme Papirus-Dark

# sudo unzip themes/Minimal_RedAccents/Minimal_RedAccents.zip -d /usr/share/themes

# sudo rm /usr/share/themes/Minimal_RedAccents/cinnamon/cinnamon.css
# sudo rm /usr/share/themes/Minimal_RedAccents/gtk-3.0/gtk.css
# sudo rm /usr/share/themes/Minimal_RedAccents/metacity-1/metacity-theme-3.xml
# sudo ln -sr themes/Minimal_RedAccents/cinnamon.css /usr/share/themes/Minimal_RedAccents/cinnamon/cinnamon.css
# sudo ln -sr themes/Minimal_RedAccents/gtk.css /usr/share/themes/Minimal_RedAccents/gtk-3.0/gtk.css
# sudo ln -sr themes/Minimal_RedAccents/metacity-theme-3.xml /usr/share/themes/Minimal_RedAccents/metacity-1/metacity-theme-3.xml
# cd ../..

# Fonts
# sudo cp -r fonts/source-code-pro/OTF /usr/share/fonts/opentype/source-code-pro
# sudo cp -r fonts/karla /usr/share/fonts/opentype/karla
# sudo cp -r fonts/webly-sleek /usr/share/fonts/truetype/webly-sleek-ui

# Rofi powermenu
# cd rofi-blurry-powermenu
# sudo cp -r fonts/* /usr/share/fonts 
# mkdir -p ~/.config/rofi
# ln -sr powermenu_theme.rasi powermenu.sh ~/.config/rofi

# Applets and extensions
# ./cinnamon/install-spices.sh

# Nemo keybindings and configuration ---------------------------------------------
# dconf load / < ~/dotfiles_linuxMint/dconf-files/nemo-fileman.conf
# rm -rf ~/.gnome2
# ln -sr homedir/gnome2 ~/.gnome2

# System configuration -----------------------------------------------------------
# ln -sr homedir/mylaunchers ~/.mylaunchers       # Custom launchers (for keybindings)
# dconf load / < ~/dotfiles_linuxMint/dconf-files/desktop-keybindings.conf

# dconf load /org/gnome/terminal/ < ~/dotfiles_linuxMint/dconf-files/gnome-terminal.conf
# dconf load /org/cinnamon/ < ~/dotfiles_linuxMint/dconf-files/system-sounds.conf
# dconf load / < ~/dotfiles_linuxMint/dconf-files/miscellaneous.conf


# -------------------------------------------------------------------------------

# rm -rf ~/.config/onedrive/config
# ln -sr config/onedrive/config ~/.config/onedrive/config

# Fan control (thinkpad x1y3)
# sudo cp -r fan-control/thinkfan_acpi.conf /etc/modprobe.d/
# modprobe -r thinkpad_acpi && modprobe thinkpad_acpi
# systemctl enable thinkfan
