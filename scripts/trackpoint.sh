#!/bin/bash
#--------------------------------------------------------------
# Change mouse DPI
# github.com/lu0
# -------------------------------------------------------------
# Bind it to a gesture   using
# 'easystroke' (sudo apt-get install easystroke)
#
# xinput list-props 'TPPS/2 Elan TrackPoint'         # List properties
# -------------------------------------------------------------

SLOW=-0.7
FAST=0.1
CURRENT_SPEED=$( xinput list-props 'TPPS/2 Elan TrackPoint' | grep 'libinput Accel Speed (' | cut -d ':' -f 2 | xargs )
CURRENT_PROFILE=$( xinput list-props 'TPPS/2 Elan TrackPoint' | grep 'libinput Accel Profile Enabled (' | cut -d ':' -f 2 | xargs )

xinput --set-prop 'TPPS/2 Elan TrackPoint' 'libinput Accel Profile Enabled' 1, 0

# xinput --set-prop 'TPPS/2 Elan TrackPoint' 'libinput Accel Profile Enabled' 0, 1
# xinput --set-prop 'TPPS/2 Elan TrackPoint' 'libinput Accel Speed' 1

[ "$CURRENT_PROFILE" != "1, 0" ] && CURRENT_SPEED=2                                                 # Force Default speed

if (( $(echo "$CURRENT_SPEED == $FAST" | bc -l) )); then
    xinput --set-prop 'TPPS/2 Elan TrackPoint' 'libinput Accel Speed' $SLOW
else
    xinput --set-prop 'TPPS/2 Elan TrackPoint' 'libinput Accel Speed'  $FAST
fi
