#!/bin/bash

# Center window on screen
# Resolution: any
#
# Map this script to your preferred keybinding
#

panel_w=36          # when using vertical panel, mine is 36px wide as in
                    # cat ~/.dotfiles_linuxMint/dconf-files/panel.conf | grep -w "panels-height"

# Load display_info library to retrieve DISPLAY_INFO for the current screen.
script_abs_file_path=$(readlink -f "$(which "${BASH_SOURCE[0]}")")
script_abs_dir_path=$(dirname ${script_abs_file_path})
source "${script_abs_dir_path}/../display_info.sh"
display_info::store
echo ${DISPLAY_INFO[x]}
echo ${DISPLAY_INFO[y]}

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
wmctrl -r :ACTIVE: -e 0,$((100 + DISPLAY_INFO[x])),$((100 + DISPLAY_INFO[y])),500,500    # dummy dimensions to avoid bugs
wmctrl -r :ACTIVE: -e 0,$((new_x + DISPLAY_INFO[x] - fix)),$((new_y + DISPLAY_INFO[y] - fix)),$((win_w)),$((win_h))

# Move mouse to the center of the screen
# xdotool mousemove $((real_width/2 + panel_w + DISPLAY_INFO[x])) $((height/2 + DISPLAY_INFO[y]))
xdotool mousemove $(( DISPLAY_INFO[width]/2 + DISPLAY_INFO[x] )) $(( DISPLAY_INFO[height]/2 + DISPLAY_INFO[y] ))
