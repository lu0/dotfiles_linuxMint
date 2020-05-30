#!/bin/bash

# This scripts install the dotfiles on a new 
# Linux Mint Cinnamon (Ubuntu edition) installation.
# 
# Author: Lucero Alvarado
# Repository: https://github.com/lu0/mint_dotfiles


# Autostart applications
sudo rm -rf ~/.config/autostart
ln -s ~/dotfiles_LinuxMint/config/autostart ~/.config/autostart

# Bash style
ln -s ~/dotfiles_LinuxMint/.fancy-bash-promt.sh ~/.fancy-bash-promt.sh

# Startup script (open fave apps)
ln -s ~/dotfiles_LinuxMint/.startup_session.sh ~/.startup_session.sh

# Custom launchers (for keybindings)
ln -s ~/dotfiles_LinuxMint/mylaunchers ~/.mylaunchers

# Custom keys
# ln -s ~/dotfiles_LinuxMint/xmodmap_edit.lst ~/.xmodmap_edit.lst

rm -rf /usr/share/X11/xkb/types/complete
ln -s ~/dotfiles_LinuxMint/keymappings/complete /usr/share/X11/xkb/types/complete

rm -rf /usr/share/X11/xkb/types/iso9995
ln -s ~/dotfiles_LinuxMint/keymappings/iso9995 /usr/share/X11/xkb/types/iso995

rm -rf /usr/share/X11/xkb/types/extra
ln -s ~/dotfiles_LinuxMint/keymappings/extra /usr/share/X11/xkb/types/extra

rm -rf /usr/share/X11/xkb/symbols/latin
ln -s ~/dotfiles_LinuxMint/keymappings/latin /usr/share/X11/xkb/symbols/latin

rm -rf /usr/share/X11/xkb/symbols/latam
ln -s ~/dotfiles_LinuxMint/keymappings/latam /usr/share/X11/xkb/symbols/latam

rm -rf /usr/share/X11/xkb/symbols/la
ln -s ~/dotfiles_LinuxMint/keymappings/la /usr/share/X11/xkb/symbols/la


# sudo ln -s ~/dotfiles_LinuxMint/config/90-custom-kbd.conf /usr/share/X11/xorg.conf.d/90-custom-kbd.conf

# rm -rf ~/.config/nemo/accels
# ln -s ~/dotfiles_LinuxMint/config/nemo/accels ~/.config/nemo/accels

rm -rf ~/.config/gtk-3.0/bookmarks
ln -s ~/dotfiles_LinuxMint/config/gtk-3.0/bookmarks ~/.config/gtk-3.0/

# VS code --------------------------------------------------------------------------------------
rm -rf ~/.config/Code/User/settings.json
ln -s ~/dotfiles_LinuxMint/config/vscode/settings.json ~/.config/Code/User/settings.json

rm -rf ~/.config/Code/User/keybindings.json
ln -s ~/dotfiles_LinuxMint/config/vscode/keybindings.json ~/.config/Code/User/keybindings.json

rm -rf ~/.config/Code/storage.json
ln -s ~/dotfiles_LinuxMint/config/vscode/storage.json ~/.config/Code/storage.json

rm -rf ~/.config/Code/rapid_render.json
ln -s ~/dotfiles_LinuxMint/config/vscode/rapid_render.json ~/.config/Code/rapid_render.json

rm -rf ~/.config/Code/rapid_render.json
ln -s ~/dotfiles_LinuxMint/config/vscode/rapid_render.json ~/.config/Code/rapid_render.json
# ----------------------------------------------------------------------------------------------

rm -rf ~/.config/onedrive/config
ln -s ~/dotfiles_LinuxMint/config/onedrive/config ~/.config/onedrive/config

rm -rf ~/.config/mintmenu/-snap-code-29-meta-gui-com.visualstudio.code.png
ln -s ~/dotfiles_LinuxMint/config/-snap-code-29-meta-gui-com.visualstudio.code.png ~/.config/mintmenu/-snap-code-29-meta-gui-com.visualstudio.code.png

# Nemo keybindings
rm -rf ~/.gnome2
ln -s ~/dotfiles_LinuxMint/gnome2 ~/.gnome2
