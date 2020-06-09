#!/bin/bash

cp ~/dotfiles_linuxMint/dconf-files/dconf_backup.conf ~/dotfiles_linuxMint/dconf-files/dconf.conf
dconf load / < ~/dotfiles_linuxMint/dconf-files/dconf_backup.conf
notify-send "Previous dconf imported!"
