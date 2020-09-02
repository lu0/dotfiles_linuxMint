#!/bin/bash

# "Tile" (with gaps) active window down
# Resolution: 1366 x 768
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

if [[ "$gx" -lt 1323 || "$gy" -lt 753 ]]; then
    wmctrl -r :ACTIVE: -b remove,maximized_horz,maximized_vert
    wmctrl -r :ACTIVE: -e 0,40,3,1324,754    # dummy dimensions to avoid bugs
    wmctrl -r :ACTIVE: -e 0,$((35 - fix)),$((8 - fix)),1323,753
else
    wmctrl -r :ACTIVE: -e 0,$((282 - fix)),$((132 - fix)),800,500
fi
