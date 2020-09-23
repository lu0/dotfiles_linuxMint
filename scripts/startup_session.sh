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

# --------- Start applications -----------------------------------------------

# Web browser, file explorer and VSCode
vivaldi & sleep 1
nemo & sleep 1
code & sleep 1

# General purpose terminal and Synergy logs
gnome-terminal & gnome-terminal -e "synergys -f"

# Web Browser for WebDev
vivaldi --new-window "http://localhost:8100" "https:/localhost:8080/swagger-ui.html" "github.com/orlando26/cubing-mty-app" "github.com/orlando26/cubing-mty-app" & sleep 1

# Syncthing
syncthing -no-browser & vivaldi --new-window "http://127.0.0.1:8384" & sleep 1

# Calendar, Mail and Social media
vivaldi --new-window "calendar.google.com/calendar/u/0/r/customday" "web.whatsapp.com" "www.messenger.com/t/lu0ear" "app.slack.com/client/T011D2D3RQF/C011D2D3SBZ" "trello.com/lu0ear/boards" "mail.google.com/mail/u/1/#inbox" "outlook.office.com/mail/inbox" "mail.google.com/mail/u/0/#inbox" & sleep 3

# Spotify (for Workspace 5)
spotify & sleep 8


# ----------- Resize windows -----------------------------------------------

# Get Vivaldi windows
VIVALDIWIN=$(wmctrl -lG | grep "Vivaldi" | awk '{print $1}')
STARTPAGE=$(echo $VIVALDIWIN | cut -d ' ' -f 1)
DEVBROWSER=$(echo $VIVALDIWIN | cut -d ' ' -f 2)
SYNCTHING=$(echo $VIVALDIWIN | cut -d ' ' -f 3)
SOCIALMEDIA=$(echo $VIVALDIWIN | cut -d ' ' -f 4)
wmctrl -i -r $STARTPAGE -b remove,maximized_horz,maximized_vert && wmctrl -i -r $STARTPAGE -e 0,46,10,1864,1060 && \
wmctrl -i -r $DEVBROWSER -b remove,maximized_horz,maximized_vert && wmctrl -i -r $DEVBROWSER -e 0,1183,10,727,1060 && \
wmctrl -i -r $SYNCTHING -b remove,maximized_horz,maximized_vert && wmctrl -i -r $SYNCTHING -e 0,1183,10,727,1060 && \
wmctrl -i -r $SOCIALMEDIA -b remove,maximized_horz,maximized_vert && wmctrl -i -r $SOCIALMEDIA -e 0,46,10,1864,1060 & sleep 1

wmctrl -r "(home)" -b remove,maximized_horz,maximized_vert && wmctrl -r "(home)" -e 0,44,8,1124,646 && \
wmctrl -r "Terminal" -b remove,maximized_horz,maximized_vert && wmctrl -r "Terminal" -e 0,43,676,1124,393 && \
wmctrl -r "Visual Studio Code" -b remove,maximized_horz,maximized_vert && wmctrl -r "Visual Studio Code" -e 0,46,10,1127,1060 && \
wmctrl -r "Spotify" -b remove,maximized_horz,maximized_vert && wmctrl -r "Spotify" -e 0,46,10,1864,1060 & sleep 2

# ----------- Move windows to desired workspaces ---------------------------
wmctrl -i -r $STARTPAGE -t 0 && \
wmctrl -r "Visual Studio Code" -t 2 && \
wmctrl -i -r $DEVBROWSER -t 2 && \
wmctrl -r Home -t 3 && \
wmctrl -r "(home)" -t 4 && \
wmctrl -r "Terminal" -t 4 && \
wmctrl -i -r $SYNCTHING -t 4 && \
wmctrl -i -r $SOCIALMEDIA -t 5 && \
wmctrl -r Spotify Premium -t 7

# ------ Focus on 2nd workspace (production) -------------------------------
wmctrl -s 2

# ------- Play sound when ready --------------------------------------------
# cpuLoad=`mpstat 2 1 | awk 'END{print 100-$NF}'`
sleep 10 && play /usr/share/sounds/freedesktop/stereo/service-login.oga
