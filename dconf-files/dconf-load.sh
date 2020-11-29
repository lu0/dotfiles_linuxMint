#!/bin/bash

#
# Wiki
# https://github.com/linuxmint/Cinnamon/wiki/Backing-up-and-restoring-your-cinnamon-settings-(dconf)
# 

cd dconf-files
dconf load / < cinnamon-theme.conf
dconf load /org/cinnamon/desktop/keybindings/ < cinnamon-shortcuts.conf
dconf load /org/gnome/terminal/ < gnome-terminal.conf
dconf load / < miscellaneous.conf
dconf load / < nemo-fileman.conf
dconf load / < panel.conf
dconf load /org/cinnamon/ < system-sounds.conf
cd ..
