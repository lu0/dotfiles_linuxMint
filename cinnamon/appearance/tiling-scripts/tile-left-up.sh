#!/bin/bash

# "Tile" (with gaps) active window left-up
# Resolution: 1920 x 1080
#
# Map this script to your preferred keybinding

wmctrl -r :ACTIVE: -b remove,maximized_horz,maximized_vert
wmctrl -r :ACTIVE: -e 0,46,10,927,525
