#!/bin/bash

# Keymappings for thinkpad Dell 5437

# Restore default configuration
setxkbmap -option

# Latin-american layout
setxkbmap latam
# setxkbmap us set-keymap us  # english(us)

# Media and vim keys
xmodmap ~/.myscripts/.customkeys-config.lst

# Modifier as escape
xcape -e 'Mode_switch=Escape'
