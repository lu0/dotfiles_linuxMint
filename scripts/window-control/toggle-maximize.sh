#!/bin/bash

# "Tile" (with gaps) active window down
# Resolution: 1920 x 1080
#
# Map this script to your preferred keybinding
#

# Get absolute positions
px="$(xwininfo -id $(xdotool getactivewindow) | egrep -i "Absolute upper-left X" | cut -d ':' -f 2)"
rx="$(xwininfo -id $(xdotool getactivewindow) | egrep "Relative upper-left X" | cut -d ':' -f 2)"

# Gnome apps have identical absolute and relative positions,
# other windows need a 2px correction when setting their position
[[ $px -eq $rx ]] && fix=0 || fix=2

gx="$(xwininfo -id $(xdotool getactivewindow) | egrep "Width" | cut -d ':' -f 2)"
gy="$(xwininfo -id $(xdotool getactivewindow) | egrep "Height" | cut -d ':' -f 2)"

if [[ "$gx" -lt 1864 || "$gy" -lt 1060 ]]; then
    wmctrl -r :ACTIVE: -b remove,maximized_horz,maximized_vert
    wmctrl -r :ACTIVE: -e 0,43,7,1863,1059    # dummy dimensions to avoid bugs
    wmctrl -r :ACTIVE: -e 0,$((46 - fix)),$((10 - fix)),1864,1060
else
    wmctrl -r :ACTIVE: -e 0,$((458 - fix)),$((182 - fix)),1004,716
fi
