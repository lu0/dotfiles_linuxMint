#!/bin/bash

# This scripts opens my favorite apps in several workspaces
#
# Run at startup with Mint's "Startup apps" or
# map it to a shortcut (ex. ctrl-super-alt-home) from:
#     ~/git_lu0/mint_dotfiles/.startup_bash.sh
# 
# Author: Lucero Alvarado
# Repository: https://github.com/lu0/mint_dotfiles

sleep 1

# ----------- Maximize windows and hide decorations -------------------------
maximus


# ------- Disable networking (faster loading on web windows) ----------------
sleep 0.5 & gsettings set org.cinnamon.desktop.notifications display-notifications false
sleep 0.5 & nmcli networking off


# ----------- Create workspaces ---------------------------------------------
# I use 6 workspaces, if they don't exist use:
# wmctrl -n 6


# ---------- Keyboard layout ------------------------------------------------
sleep 0.5 & setxkbmap latam             # latin-american
# sleep 0.5 & setxkbmap us set-keymap us  # english(us)


# --------- Remap keys (at startup) -----------------------------------------
# xmodmap ~/.xmodmap_edit.lst 
# notConnected=`lsusb -v 2>/dev/null | egrep '(^Bus|Keyboard)' | grep -B1 Keyboard `
# if [ $? -eq 0 ]
# then
#    # Remap keys to match Logitech Wireless keyboard
#     xmodmap -e "keycode 110 = Home"
#     xmodmap -e "keycode 115 = End"
#     xmodmap -e "keycode 112 = Prior"
#     xmodmap -e "keycode 117 = Next"
#     # echo "External keyboard"
# else
#   # Remap keys to match Dell 5437 keyboard
#     xmodmap -e "keycode 112 = End"
#     xmodmap -e "keycode 117 = Prior"
#     xmodmap -e "keycode 115 = Next"
#     # echo "Dell keyboard"
# fi
sleep 0.5

# Custom media keys for ThinkPad X1Y3
xmodmap keymappings/mediaKeys_ThinkPadX1Y3.lst


# ---------Start applications -----------------------------------------------

# Empty Web window (restore last session is disabled in my settings)
vivaldi --start-maximized & sleep 1

nemo & sleep 0.5                       # File explorer

code & sleep 0.5                        # Visual Studio Code (add -n if empty window is desired)

# Web window for App under development (https://github.com/orlando26/cubing-mty-app)
vivaldi --new-window "http://localhost:8100" "https:/localhost:8080/swagger-ui.html" "github.com/orlando26/cubing-mty-app" "github.com/orlando26/cubing-mty-app" & sleep 1

# Web window for Social media and Mail
vivaldi --new-window --start-maximized "www.messenger.com/t/lu0ear" "web.whatsapp.com" "app.slack.com/client/T011D2D3RQF/C011D2D3SBZ" "mail.google.com/mail/u/0/#inbox" "outlook.office.com/mail/inbox" "mail.google.com/mail/u/1/#inbox" "trello.com/lu0ear/boards" & sleep 1

# General purpose terminal and Onedrive journal terminal (For Workspace 3)
gnome-terminal --profile OnedriveStatus -e "journalctl --user-unit onedrive -f" & sleep 0.5
gnome-terminal & sleep 3

# Spotify (for Workspace 5)
spotify & sleep 8


# ----------- Resize windows -----------------------------------------------

wmctrl -r "Terminal" -N "OnedriveUANL Journal" & sleep 0.5   # Rename Onedrive terminal
wmctrl -r "OnedriveUANL Journal" -b remove,maximized_horz,maximized_vert
wmctrl -r "OnedriveUANL Journal" -e 0,830,0,540,768 & sleep 0.5

# General purpose terminal
wmctrl -r lucero:~ -b remove,maximized_horz,maximized_vert & sleep 0.5
wmctrl -r lucero:~ -e 0,0,0,790,768 & sleep 0.5

wmctrl -r "Visual Studio Code" -b remove,maximized_horz,maximized_vert
wmctrl -r "Visual Studio Code" -e 0,0,0,790,768 & sleep 0.5

# Vivaldi window for App dev.
wmctrl -r "localhost" -b remove,maximized_horz,maximized_vert
wmctrl -r "localhost" -e 0,830,0,540,768 & sleep 0.5


# ----------- Move windows to desired workspaces ---------------------------
wmctrl -r Vivaldi -t 0                    # General purpose Web Browser
wmctrl -r Home -t 1                       # Nemo file browser
wmctrl -r "Visual Studio Code" -t 2
wmctrl -r "localhost" -t 2                # App dev Web Browser
wmctrl -r lucero:~ -t 3                   # General purpose terminal
wmctrl -r "OnedriveUANL Journal" -t 3     
wmctrl -r "messenger" -t 4                # Social Media Web Browser
wmctrl -r Spotify Premium -t 5 


# ------ Focus on 2nd workspace (production) -------------------------------
sleep 0.5 & wmctrl -s 2


# ------- Enable networking (faster loading on web windows) ----------------
sleep 0.5 & nmcli networking on


# ------ Initialize Onedrive -----------------------------------------------
sleep 3
systemctl --user enable onedrive
systemctl --user start onedrive
# onedrive --monitor


# ------- Play sound when ready --------------------------------------------
# cpuLoad=`mpstat 2 1 | awk 'END{print 100-$NF}'`
sleep 1
play ~/git_lu0/mint_dotfiles/mySystemSounds/login_oot.wav


# ------- Enable notifications ---------------------------------------------
sleep 10 & gsettings set org.cinnamon.desktop.notifications display-notifications true
