#!/bin/bash

cd dconf-files
dconf load /org/gnome/terminal/ < gnome-terminal.conf
dconf load /org/cinnamon/ < system-sounds.conf
dconf load / < miscellaneous.conf
dconf load / < desktop-keybindings.conf
dconf load / < nemo-fileman.conf
cd ..
