#!/bin/bash

#
# Toggle trackpoint speed
#   github.com/lu0
#
# Bind it to a gesture using
#   'easystroke' (sudo apt-get install easystroke)
#
# List devices:
#   xinput list       # list devices
#
# List properties:
#   xinput list-props 'TPPS/2 Elan TrackPoint'
#   xinput list-props 'pointer:Lenovo ThinkPad Compact USB Keyboard with TrackPoint'
#

function main() {
    BUILT_IN_TRACKPOINT='TPPS/2 Elan TrackPoint'
    toggle-trackpoint-speed "${BUILT_IN_TRACKPOINT}" -1 -0.6
    
    EXTERNAL_TRACKPOINT='pointer:Lenovo ThinkPad Compact USB Keyboard with TrackPoint'
    toggle-trackpoint-speed "${EXTERNAL_TRACKPOINT}" -0.8 -0.4
}

function toggle-trackpoint-speed() {
    DEVICE="${1}"
    SLOW="${2}"
    FAST="${3}"

    CURRENT_SPEED=$( xinput list-props "${DEVICE}" | grep 'libinput Accel Speed (' | cut -d ':' -f 2 | xargs )
    CURRENT_PROFILE=$( xinput list-props "${DEVICE}" | grep 'libinput Accel Profile Enabled (' | cut -d ':' -f 2 | xargs )

    xinput --set-prop "${DEVICE}" 'libinput Accel Profile Enabled' 1, 0

    [ "$CURRENT_PROFILE" != "1, 0" ] && CURRENT_SPEED=2     # Force Default speed

    (( $(echo "$CURRENT_SPEED == $FAST" | bc -l) )) \
        && xinput --set-prop "${DEVICE}" 'libinput Accel Speed' $SLOW \
        || xinput --set-prop "${DEVICE}" 'libinput Accel Speed'  $FAST
}

main
