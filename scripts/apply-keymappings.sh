#!/bin/bash

# Keymappings for thinkpad X1Y3

# Restore default configuration
setxkbmap -option

# Latin-american layout
setxkbmap latam
# setxkbmap us set-keymap us  # english(us)

# Swap caps and escape keys
setxkbmap -option caps:swapescape

# Media and vim keys
xmodmap ~/.myscripts/.customkeys-config.lst
