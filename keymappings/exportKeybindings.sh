#!/bin/bash

dconf dump /org/cinnamon/desktop/keybindings/ > ~/dotfiles_LinuxMint/keymappings/myKeybindings.conf
notify-send "Keybindings exported!"