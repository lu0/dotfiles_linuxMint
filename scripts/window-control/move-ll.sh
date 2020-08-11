#!/bin/bash

# Get x position
px="$(xdotool getwindowfocus getwindowgeometry | egrep -i 'position:' | cut -d ':' -f 2 | cut -d ',' -f 1)"

# Get y position
py="$(xdotool getwindowfocus getwindowgeometry | egrep -i 'position:' | cut -d ',' -f 2 | cut -d ' ' -f 1)"

# Get x geometry
gx="$(xdotool getwindowfocus getwindowgeometry | egrep -i 'geometry:' | cut -d ':' -f 2 | cut -d 'x' -f 1)"

# Get y geometry
gy="$(xdotool getwindowfocus getwindowgeometry | egrep -i 'geometry:' | cut -d ':' -f 2 | cut -d 'x' -f 2)"

res=$(($px + $py))

sleep 0.15 && wmctrl -r :ACTIVE: -e 0,$((px - 12 - 10)),$((py - 12)),$((gx + 10)),$((gy))