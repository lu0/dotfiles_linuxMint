#!/bin/bash

# This scripts opens my favorite apps in their workspaces
#
# Run at startup with Mint's "Startup apps" or
# map it to a shortcut (ex. ctrl-super-alt-home) from:
#     ~/.dotfiles_linuxMint/scripts/startup_session.sh
# 
# Author: Lucero Alvarado
# Repository: https://github.com/lu0/dotfiles_linuxMint

# ------- Disable networking and notifications (faster loading of web windows) ----------------
gsettings set org.cinnamon.desktop.notifications display-notifications false && nmcli networking off


# ----------- Create workspaces ---------------------------------------------
# I use 6 workspaces, if they don't exist use:
# wmctrl -n 6

# ---------Start applications -----------------------------------------------

vivaldi & sleep 1                    # Blank Window ("restore last session" is disabled in my vivaldi settings)
nemo & sleep 1                       # File explorer
code & sleep 1                       # Visual Studio Code (add -n if empty window is desired)

# General purpose terminal and Syncthing window (For Workspace 3)
gnome-terminal & sleep 1
gnome-terminal -e "synergys -f" & sleep 0.5

syncthing -no-browser & sleep 1                                 # Start syncthing, don't use current vivaldi window.
vivaldi --new-window "http://127.0.0.1:8384" & sleep 1          # Open syncthing on new window

# Web window for App under development (https://github.com/orlando26/cubing-mty-app)
vivaldi --new-window "http://localhost:8100" "https:/localhost:8080/swagger-ui.html" "github.com/orlando26/cubing-mty-app" "github.com/orlando26/cubing-mty-app" & sleep 1

# Web window for Social media and Mail
vivaldi --new-window "www.messenger.com/t/lu0ear" "web.whatsapp.com" "app.slack.com/client/T011D2D3RQF/C011D2D3SBZ" "mail.google.com/mail/u/0/#inbox" "outlook.office.com/mail/inbox" "mail.google.com/mail/u/1/#inbox" "trello.com/lu0ear/boards" & sleep 1

# Spotify (for Workspace 5)
spotify & sleep 3


# ----------- Resize windows -----------------------------------------------

wmctrl -r "Start Page" -e 0,46,10,1864,1060 && wmctrl -r Home -e 0,46,10,1864,1060 & sleep 0.5

wmctrl -r "(home)" -b remove,maximized_horz,maximized_vert && wmctrl -r "(home)" -e 0,44,8,1124,646 & sleep 0.5
wmctrl -r "Terminal" -b remove,maximized_horz,maximized_vert && wmctrl -r "Terminal" -e 0,43,676,1124,393 & sleep 0.5

wmctrl -r "| Syncthing" -b remove,maximized_horz,maximized_vert && wmctrl -r "| Syncthing" -e 0,1183,10,727,1060 & sleep 0.5

wmctrl -r "Visual Studio Code" -b remove,maximized_horz,maximized_vert && wmctrl -r "Visual Studio Code" -e 0,46,10,1127,1060 & sleep 1

# Vivaldi window for App dev.
wmctrl -r "localhost" -b remove,maximized_horz,maximized_vert && wmctrl -r "localhost" -e 0,1183,10,727,1060 & sleep 0.5

wmctrl -r "messenger" -e 0,46,10,1864,1060 && wmctrl -r Spotify Premium -e 0,46,10,1864,1060 & sleep 0.5


# ----------- Move windows to desired workspaces ---------------------------
wmctrl -r Vivaldi -t 0                    # General purpose Web Browser
wmctrl -r "Visual Studio Code" -t 2
wmctrl -r "localhost" -t 2                # App dev Web Browser
wmctrl -r Home -t 3                       # Nemo file browser
wmctrl -r "(home)" -t 4                   # General purpose terminal
wmctrl -r "Terminal" -t 4                   # General purpose terminal
wmctrl -r "| Syncthing" -t 4     
wmctrl -r "messenger" -t 5                # Social Media Web Browser
wmctrl -r Spotify Premium -t 7 


# ------ Focus on 2nd workspace (production) -------------------------------
sleep 0.5 && wmctrl -s 2


# ------- Enable networking (faster loading on web windows) ----------------
sleep 0.5 && nmcli networking on

# ------- Play sound when ready --------------------------------------------
# cpuLoad=`mpstat 2 1 | awk 'END{print 100-$NF}'`
sleep 1
play /usr/share/sounds/freedesktop/stereo/service-login.oga

# ------- Undervolting -----------------------------------------------------
sleep 5 && sudo undervolt --temp 75
sleep 3 && sudo undervolt --core -60 --cache -60

# ------- Enable notifications ---------------------------------------------
sleep 10 && gsettings set org.cinnamon.desktop.notifications display-notifications true
