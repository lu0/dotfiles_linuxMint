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
sleep 1
# zenity --info --text '<span foreground="blue" font="32">Some\nbig text</span>\n\n<i>(it is also blue)</i>'
if zenity --question --title "Startup" --text "Start your favorite programs?" --ok-label="Please!" --cancel-label="Nah"
then
    vivaldi & sleep 1
    nemo & sleep 1
    code ~/code/dotfiles_linuxMint & sleep 1
    code ~/code/tecnoap & sleep 1
    # code ~/code/tecnoap/projects-ssy/ssy/codigo/SensorVolumen & sleep 1
    code ~/code/tecnoap/projects-ssy/ssy/codigo/ngx-admin & sleep 1

    # General purpose terminal and Synergy logs
    gnome-terminal & gnome-terminal -e "synergys -f"

    # Web Browser for WebDev
    CURRENT_HOUR=$(date +%R | cut -d ':' -f 1)
    if [ "$CURRENT_HOUR" -gt 6 ] &&  [ "$CURRENT_HOUR" -lt 10 ]; then
        vivaldi --new-window "https://meet.google.com/vnv-cxck-udp" "http://localhost:4200" "http://localhost:8100" "https:/localhost:8080/swagger-ui.html" "sharepoint.tecnoap.com" "jira.tecnoap.com" & sleep 1
    else
        vivaldi --new-window "http://localhost:4200" "http://localhost:8100" "https:/localhost:8080/swagger-ui.html" "sharepoint.tecnoap.com" "jira.tecnoap.com" & sleep 1
    fi
    # "github.com/orlando26/cubing-mty-app" "github.com/orlando26/cubing-mty-app"

    # Mail
    thunderbird & sleep 1

    # Syncthing
    syncthing -no-browser & vivaldi --new-window "http://127.0.0.1:8384" & sleep 1

    # Calendar, mail and social media
    vivaldi --new-window "calendar.google.com/calendar/u/0/r/customday" "app.slack.com/client/T011D2D3RQF/C011D2D3SBZ" "trello.com/lu0ear/boards" "mail.tecnoap.com" & sleep 3

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
    wmctrl -i -r $DEVBROWSER -b remove,maximized_horz,maximized_vert && wmctrl -i -r $DEVBROWSER -e 0,46,10,1864,1060 && \
    wmctrl -i -r $SYNCTHING -b remove,maximized_horz,maximized_vert && wmctrl -i -r $SYNCTHING -e 0,1183,10,727,1060 && \
    wmctrl -i -r $SOCIALMEDIA -b remove,maximized_horz,maximized_vert && wmctrl -i -r $SOCIALMEDIA -e 0,983,10,927,1060 & sleep 1

    wmctrl -r "(home)" -b remove,maximized_horz,maximized_vert && wmctrl -r "(home)" -e 0,44,8,1124,646 && \
    wmctrl -r "Terminal" -b remove,maximized_horz,maximized_vert && wmctrl -r "Terminal" -e 0,43,676,1124,393 && \
    wmctrl -r "dotfiles_linuxMint" -b remove,maximized_horz,maximized_vert && wmctrl -r "dotfiles_linuxMint" -e 0,46,10,1864,1060 && \
    wmctrl -r "tecnoap" -b remove,maximized_horz,maximized_vert && wmctrl -r "tecnoap" -e 0,46,10,1864,1060 && \
    wmctrl -r "ngx-admin" -b remove,maximized_horz,maximized_vert && wmctrl -r "ngx-admin" -e 0,46,10,1864,1060 && \
    wmctrl -r "Thunderbird" -b remove,maximized_horz,maximized_vert && wmctrl -r "Thunderbird" -e 0,46,10,927,1060 && sleep 2 \
    wmctrl -r "Spotify" -b remove,maximized_horz,maximized_vert && wmctrl -r "Spotify" -e 0,46,10,1864,1060 & sleep 3

    # ----------- Move windows to desired workspaces ---------------------------
    wmctrl -i -r $STARTPAGE -t 0 && \
    wmctrl -r "dotfiles_linuxMint" -t 2 && \
    wmctrl -r "tecnoap" -t 2 && \
    wmctrl -r "ngx-admin" -t 2 && \
    wmctrl -i -r $DEVBROWSER -t 2 && \
    wmctrl -r Home -t 3 && \
    wmctrl -r "(home)" -t 4 && \
    wmctrl -r "Terminal" -t 4 && \
    wmctrl -i -r $SYNCTHING -t 4 && \
    wmctrl -i -r $SOCIALMEDIA -t 5 && \
    wmctrl -r "Thunderbird" -t 5 && \
    wmctrl -r Spotify Premium -t 7

    # ------ Focus on 2nd workspace (production) -------------------------------
    wmctrl -s 2


    # -------- Misc ------------------------------------------------------------
    # watch -n 2 screenshot-watcher.sh
fi

# Default dpi
dpi.sh

# Touchpad config
xinput --set-prop 'SynPS/2 Synaptics TouchPad' 'Synaptics Noise Cancellation' 0, 0
xinput --set-prop 'SynPS/2 Synaptics TouchPad' 'Device Accel Constant Deceleration' 2

# ------- Play sound when ready --------------------------------------------
# cpuLoad=`mpstat 2 1 | awk 'END{print 100-$NF}'`
~/code/dotfiles_linuxMint/scripts/hdmi-sound.sh
sleep 10 && play /usr/share/sounds/freedesktop/stereo/service-login.oga