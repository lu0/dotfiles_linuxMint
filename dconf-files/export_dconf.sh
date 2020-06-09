#!/bin/bash

cp ~/dotfiles_linuxMint/dconf-files/dconf.conf ~/dotfiles_linuxMint/dconf-files/dconf_backup.conf
dconf dump / > ~/dotfiles_linuxMint/dconf-files/dconf.conf
notify-send "Current dconf exported!"
