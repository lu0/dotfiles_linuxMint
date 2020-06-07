#!/bin/bash

cp ~/dotfiles_linuxMint/config/dconf.conf ~/dotfiles_linuxMint/config/dconf_backup.conf
dconf dump / > ~/dotfiles_linuxMint/config/dconf.conf
notify-send "Current dconf exported!"
