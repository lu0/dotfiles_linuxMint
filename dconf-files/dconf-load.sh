#!/bin/bash

dconf load /org/gnome/terminal/ < gnome-terminal.conf
dconf load /org/cinnamon/ < system-sounds.conf
dconf load / < miscellaneous.conf
dconf load / < desktop-keybindings.conf
