#!/bin/bash

# "Tile" (with gaps) active window down
# Resolution: 1920 x 1080
#
# Map this script to your preferred keybinding

id=$(xdotool getactivewindow)
dimensions=$(wmctrl -lpG | while read -a a; do w=${a[0]}; if (($((16#${w:2}))==id)) ; then echo -n "${a[5]} ${a[6]}"; break; fi; done)

set -- $dimensions  ## $1=X $1=Y
if [[ "$1" -lt 1864 || "$2" -lt 1010 ]]; then
    wmctrl -r :ACTIVE: -e 0,46,46,1864,1024
elif [[ "$1" -gt 1864 && "$2" -gt 1010 ]]; then
    wmctrl -r :ACTIVE: -b remove,maximized_horz,maximized_vert
    wmctrl -r :ACTIVE: -e 0,46,46,1864,1024
else
    wmctrl -r :ACTIVE: -e 0,459,183,1004,716
fi
