#!/bin/bash

gnome-calculator & disown   # open calculator and recover control of the terminal
sleep 0.8                   # wait for "Calculator" to appear in wmctrl list 
wmctrl -r Calculator -b add,maximized_vert,maximized_horz   # Maximize window

