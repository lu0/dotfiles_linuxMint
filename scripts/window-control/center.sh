#!/bin/bash

# Center window on screen
# Resolution: any
#
# Map this script to your preferred keybinding
#

panel_w=36          # when using vertical panel, mine is 36px wide as in
                    # cat ~/.dotfiles_linuxMint/dconf-files/panel.conf | grep -w "panels-height"

# Get $MONITOR, $RESOLUTION, $X_OFFSET, $Y_OFFSET, 
# $width and $height of the current screen
# previously added to PATH from ~/.dotfiles_linuxMint/scripts/
source devilspie_screen

# Get absolute and relative positions of the window
px="$(xwininfo -id $(xdotool getactivewindow) | egrep -i "Absolute upper-left X" | cut -d ':' -f 2)"
rx="$(xwininfo -id $(xdotool getactivewindow) | egrep "Relative upper-left X" | cut -d ':' -f 2)"

# Gnome apps have identical absolute and relative positions,
# other windows need a 2px correction when setting their position
[[ $px -eq $rx ]] && fix=0 || fix=2

win_w="$(xwininfo -id $(xdotool getactivewindow) | egrep "Width" | cut -d ':' -f 2)"
win_h="$(xwininfo -id $(xdotool getactivewindow) | egrep "Height" | cut -d ':' -f 2)"

real_width=$((width - panel_w))

new_x=$(( (real_width - win_w)/2 + panel_w ))
new_y=$(( (height - win_h)/2 ))

# Move window to its new position
wmctrl -r :ACTIVE: -b remove,maximized_horz,maximized_vert
wmctrl -r :ACTIVE: -e 0,$((100 + X_OFFSET)),$((100 + Y_OFFSET)),500,500    # dummy dimensions to avoid bugs
wmctrl -r :ACTIVE: -e 0,$((new_x + X_OFFSET - fix)),$((new_y + Y_OFFSET - fix)),$((win_w)),$((win_h))

# Move mouse to the center of the screen
xdotool mousemove $((real_width/2 + panel_w + X_OFFSET)) $((height/2 + Y_OFFSET))
