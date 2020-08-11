#!/bin/bash

# "Tile" (with gaps) active window down
# Resolution: 1920 x 1080
#
# Map this script to your preferred keybinding

wmctrl -r :ACTIVE: -b remove,maximized_horz,maximized_vert
wmctrl -r :ACTIVE: -e 0,500,500,500,500    # dummy dimensions to avoid bugs
wmctrl -r :ACTIVE: -e 0,44,544,1864,524
