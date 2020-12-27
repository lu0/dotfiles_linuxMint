#!/bin/bash
#--------------------------------------------------------------
# Change mouse DPI
# github.com/lu0
# -------------------------------------------------------------
# Bind it to a configurable mouse button using
# 'easystroke' (sudo apt-get install easystroke)
#
# xinput list-props 'Logitech M570'         # List properties
# -------------------------------------------------------------

SLOW=-0.8
FAST=-0.1
CURRENT_SPEED=$( xinput list-props 'Logitech M570' | grep 'libinput Accel Speed (' | cut -d ':' -f 2 | xargs )
CURRENT_PROFILE=$( xinput list-props 'Logitech M570' | grep 'libinput Accel Profile Enabled (' | cut -d ':' -f 2 | xargs )

xinput --set-prop 'Logitech M570' 'libinput Accel Profile Enabled' 0, 1                                 # slowest profile

[ "$CURRENT_PROFILE" != "0, 1" ] && CURRENT_SPEED=2                                                 # Force Default speed

if (( $(echo "$CURRENT_SPEED == $FAST" | bc -l) )); then
    xinput --set-prop 'Logitech M570' 'libinput Accel Speed' $SLOW
else
    xinput --set-prop 'Logitech M570' 'libinput Accel Speed'  $FAST
fi
