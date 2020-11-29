#!/bin/bash

# "Tile" (with gaps) active window left-up
# Resolution: 1920 x 1080
#
# Map this script to your preferred keybinding

eval $(xdotool getmouselocation --shell)   # returns X, Y
if [ $Y -le 1080 ]; then
    fix_x=0
    fix_y=0
else
    fix_x=15
    fix_y=1080
fi

wmctrl -r :ACTIVE: -b remove,maximized_horz,maximized_vert
wmctrl -r :ACTIVE: -e 0,500,500,500,500    # dummy dimensions to avoid bugs
wmctrl -r :ACTIVE: -e 0,$((44 + fix_x)),$((8 + fix_y)),927,524

xdotool mousemove $((535 + fix_x)) $((265 + fix_y))
