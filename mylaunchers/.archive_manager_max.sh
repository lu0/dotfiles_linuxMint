#!/bin/bash

file-roller & disown   # open calculator and recover control of the terminal
sleep 0.4                   # wait for "Calculator" to appear in wmctrl list 
wmctrl -r Archive Manager -b add,maximized_vert,maximized_horz   # Maximize window

