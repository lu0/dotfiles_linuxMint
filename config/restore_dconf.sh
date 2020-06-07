#!/bin/bash

cp ~/dotfiles_linuxMint/config/dconf_backup.conf ~/dotfiles_linuxMint/config/dconf.conf
dconf load / < ~/dotfiles_linuxMint/config/dconf_backup.conf
notify-send "Previous dconf imported!"
