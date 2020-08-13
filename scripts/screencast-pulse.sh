#!/bin/bash

# Record screen and audio with ffmpeg
# lu0

if pgrep ffmpeg
then
    sleep 3 && pkill ffmpeg
    notify-send -i "emblem-videos-symbolic" "Screencast" "Saved" 
else
    if zenity --question --text "Screencast" --ok-label="Start" --cancel-label="Cancel"
    then
        # Wait for dialog
        sleep 1 &&

        # Set name according to date and time
        mkdir -p $HOME/videos/screencast/
        filename=("$HOME/videos/screencast/screencast-$(date +%y%m%d)-$(date +%H%M%S).mp4")

        # Resolution of current monitor
        res=$(xdpyinfo | grep dimensions | awk '{print $2}')
        
        # Start recording. Compatible with android
        ffmpeg -y -f x11grab -s $res -r 30 -i :0.0 -f alsa -i pulse -c:v libx264 -c:a aac -ac 2 -vf format=yuv420p -movflags faststart $filename
        # ffmpeg -y -f x11grab -s $res -r 30 -i :0.0+0,0 -f alsa -i pulse -c:v h264 -c:a aac -ac 2 -vf format=yuv420p -movflags faststart $filename
        
    fi
fi
