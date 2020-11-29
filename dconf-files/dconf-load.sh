#!/bin/bash

#
# Wiki
# https://github.com/linuxmint/Cinnamon/wiki/Backing-up-and-restoring-your-cinnamon-settings-(dconf)
# 

cd dconf-files
dconf load / < theme.conf
dconf load /org/cinnamon/desktop/keybindings/ < cinnamon-shortcuts.conf
dconf load /org/gnome/terminal/ < gnome-terminal.conf
dconf load / < miscellaneous.conf
dconf load /org/nemo/ < nemo-fileman.conf
dconf load /org/cinnamon/ < panel.conf
dconf load /org/cinnamon/ < system-sounds.conf
cd ..
