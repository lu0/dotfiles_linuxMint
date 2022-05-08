#!/usr/bin/env bash

# Toggle mouse position to left/right monitor
# xrandr output:
# left: 1920x1080+0+0
# right: 2560x1440+1920+0

# Hardcoded X resolution of the left monitor
left_x_max=1920

# Total resolution: X
x_res=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d'x' -f1)

# Total resolution: Y
y_res=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d'x' -f2)

# Make Y/2 the default cursor location
new_y=$(( y_res / 2 ))

current_x=$(xdotool getmouselocation | cut -d ' ' -f1 | cut -d':' -f2)

if [[ $current_x -le ${left_x_max} ]]; then
    xdotool mousemove $(( left_x_max + 1000 )) $new_y
else
    xdotool mousemove $(( left_x_max - 1000 )) $new_y
fi
