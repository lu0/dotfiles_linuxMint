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

# Mouse keys
# 11 is the id of my m570 (xinput list)
# Map forward and backward buttons to simple click
xinput set-button-map 'Logitech M570' 1 2 3 4 5 6 7 1 9
