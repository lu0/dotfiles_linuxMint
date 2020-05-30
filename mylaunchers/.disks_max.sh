#!/bin/bash

gnome-disks & disown
sleep 3
wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz   # Maximize window

