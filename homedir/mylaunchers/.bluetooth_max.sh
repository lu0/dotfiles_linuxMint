#!/bin/bash

blueberry # open calculator and recover control of the terminal
sleep 1.2                   # wait for "Calculator" to appear in wmctrl list 
wmctrl -r Bluetooth -b add,maximized_vert,maximized_horz   # Maximize window

#blueberry & wmctrl -r Bluetooth -b add,maximized_vert,maximized_horz   # Maximize window


