#!/bin/bash

dconf load /org/gnome/terminal/ < dconf-files/gnome-terminal.conf
dconf load /org/cinnamon/ < ~/dotfiles_linuxMint/dconf-files/system-sounds.conf
dconf load / < ~/dotfiles_linuxMint/dconf-files/miscellaneous.conf
dconf load / < ~/dotfiles_linuxMint/dconf-files/desktop-keybindings.conf
