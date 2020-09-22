#!/bin/bash

# This scripts opens my favorite apps in their workspaces
#
# Run at startup with Mint's "Startup apps" or
# map it to a shortcut (ex. ctrl-super-alt-home) from:
#     ~/.dotfiles_linuxMint/scripts/startup_session.sh
# 
# Author: Lucero Alvarado
# Repository: https://github.com/lu0/dotfiles_linuxMint

# ----------- Create workspaces ---------------------------------------------
# I use 6 workspaces, if they don't exist use:
# wmctrl -n 6

# ---------Start applications -----------------------------------------------

vivaldi & sleep 1                    # Start Page ("restore session" is disabled in my vivaldi settings)
nemo & sleep 1                       # File explorer
code & sleep 1                       # Visual Studio Code (add -n if empty window is desired)

# General purpose terminal and Syncthing window (For Workspace 3)
gnome-terminal & sleep 1
gnome-terminal -e "synergys -f" & sleep 0.5

# Web Browser for WebDev
vivaldi --new-window "http://localhost:8100" "https:/localhost:8080/swagger-ui.html" "github.com/orlando26/cubing-mty-app" "github.com/orlando26/cubing-mty-app" & sleep 1

# Syncthing
syncthing -no-browser & sleep 1          
vivaldi --new-window "http://127.0.0.1:8384" & sleep 1

# Web window for Social media, Mail and Calendar
vivaldi --new-window "calendar.google.com/calendar/u/0/r/agenda" "web.whatsapp.com" "www.messenger.com/t/lu0ear" "mail.google.com/mail/u/0/#inbox" "outlook.office.com/mail/inbox" "mail.google.com/mail/u/1/#inbox" "trello.com/lu0ear/boards" "app.slack.com/client/T011D2D3RQF/C011D2D3SBZ" & sleep 1

# Spotify (for Workspace 5)
spotify & sleep 5


# ----------- Resize windows -----------------------------------------------

# Get Vivaldi windows
VIVALDIWIN=$(wmctrl -lG | grep "Vivaldi" | awk '{print $1}')
STARTPAGE=$(echo $VIVALDIWIN | cut -d ' ' -f 1)
DEVBROWSER=$(echo $VIVALDIWIN | cut -d ' ' -f 2)
SYNCTHING=$(echo $VIVALDIWIN | cut -d ' ' -f 3)
SOCIALMEDIA=$(echo $VIVALDIWIN | cut -d ' ' -f 4)
wmctrl -i -r $STARTPAGE -b remove,maximized_horz,maximized_vert && wmctrl -i -r $STARTPAGE -e 0,46,10,1864,1060 & sleep 0.5
wmctrl -i -r $DEVBROWSER -b remove,maximized_horz,maximized_vert && wmctrl -i -r $DEVBROWSER -e 0,1183,10,727,1060 & sleep 0.5
wmctrl -i -r $SYNCTHING -b remove,maximized_horz,maximized_vert && wmctrl -i -r $SYNCTHING -e 0,1183,10,727,1060 & sleep 0.5
wmctrl -i -r $SOCIALMEDIA -b remove,maximized_horz,maximized_vert && wmctrl -i -r $SOCIALMEDIA -e 0,46,10,1864,1060 & sleep 0.5

wmctrl -r "(home)" -b remove,maximized_horz,maximized_vert && wmctrl -r "(home)" -e 0,44,8,1124,646 & sleep 0.5
wmctrl -r "Terminal" -b remove,maximized_horz,maximized_vert && wmctrl -r "Terminal" -e 0,43,676,1124,393 & sleep 0.5
wmctrl -r "Visual Studio Code" -b remove,maximized_horz,maximized_vert && wmctrl -r "Visual Studio Code" -e 0,46,10,1127,1060 & sleep 1
wmctrl -r Spotify Premium -e 0,46,10,1864,1060 & sleep 1

# ----------- Move windows to desired workspaces ---------------------------
wmctrl -i -r $STARTPAGE -t 0
wmctrl -r "Visual Studio Code" -t 2
wmctrl -i -r $DEVBROWSER -t 2
wmctrl -r Home -t 3                                                     # Nemo file browser
wmctrl -r "(home)" -t 4                                                 # General purpose terminal
wmctrl -r "Terminal" -t 4                                               # Synergy log
wmctrl -i -r $SYNCTHING -t 4
wmctrl -i -r $SOCIALMEDIA -t 5
wmctrl -r Spotify Premium -t 7 

# ------ Focus on 2nd workspace (production) -------------------------------
sleep 1 && wmctrl -s 2

# ------- Play sound when ready --------------------------------------------
# cpuLoad=`mpstat 2 1 | awk 'END{print 100-$NF}'`
sleep 10 && play /usr/share/sounds/freedesktop/stereo/service-login.oga
