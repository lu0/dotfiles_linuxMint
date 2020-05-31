#!/bin/bash

dconf dump / > ~/dotfiles_LinuxMint/config/dconf.conf
notify-send "dconf exported!"