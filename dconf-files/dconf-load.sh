#!/bin/bash

cd dconf-files
dconf load / < cinnamon-theme.conf
dconf load / < desktop-keybindings.conf
dconf load /org/gnome/terminal/ < gnome-terminal.conf
dconf load / < miscellaneous.conf
dconf load / < nemo-fileman.conf
dconf load / < panel.conf
dconf load /org/cinnamon/ < system-sounds.conf
cd ..
