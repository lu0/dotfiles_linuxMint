#!/bin/bash

# The micmute (Fn+F4) button of the Thinkpad Compact USB Keyboard 
# doesn't work out of the box as its keycode (248) is outside the
# range of the X server, therefore it is not recognizable with xev.
#
# This script enables the button by connecting to the acpid socket
# to catch the acpi event and then simulate the keypress on the X server.
#
# With this running at startup, we don't need to toggle the mic with
# alsa/pulseaudio, nor do we need to implement hacky workarounds 
# to toggle the LED on the internal keyboard.
# 
# Lucero Alvarado 
#	<https://github.com/lu0>

coproc acpi_listen
trap 'kill $COPROC_PID' EXIT

while read -u "${COPROC[0]}" -a event; do
	[ "${event[0]}" = 'button/micmute' ] \
        && xdotool key XF86AudioMicMute
done
