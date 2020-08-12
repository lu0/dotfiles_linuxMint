#!/bin/bash

# 
# Move window left-to-left
# 1920x1080 resolutions
#
# author: github.com/lu0
#

# Get absolute positions
px="$(xwininfo -id $(xdotool getactivewindow) | egrep -i "Absolute upper-left X" | cut -d ':' -f 2)"
py="$(xwininfo -id $(xdotool getactivewindow) | egrep -i "Absolute upper-left Y" | cut -d ':' -f 2)"

# Get relative positions
rx="$(xwininfo -id $(xdotool getactivewindow) | egrep "Relative upper-left X" | cut -d ':' -f 2)"
ry="$(xwininfo -id $(xdotool getactivewindow) | egrep "Relative upper-left Y" | cut -d ':' -f 2)"

# Gnome apps have identical absolute and relative positions,
# other windows need a 2px correction when setting their position
[[ $px -eq $rx ]] && fix=0 || fix=2

# Get geometries
gx="$(xwininfo -id $(xdotool getactivewindow) | egrep "Width" | cut -d ':' -f 2)"
gy="$(xwininfo -id $(xdotool getactivewindow) | egrep "Height" | cut -d ':' -f 2)"

# Set new position and geometry
sleep 0.05 && wmctrl -r :ACTIVE: -e 0,$((px - fix + 10)),$((py - fix)),$((gx - 10)),$((gy))