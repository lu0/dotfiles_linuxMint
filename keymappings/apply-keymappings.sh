#!/bin/bash

# Keymappings for thinkpad X1Y3

# Restore default configuration
setxkbmap -option

# Latin-american layout
setxkbmap latam
# setxkbmap us set-keymap us  # english(us)

# Media and vim keys
xmodmap ~/.customkeys-config.lst

# Modifier as escape
xcape -e 'Mode_switch=Escape'
