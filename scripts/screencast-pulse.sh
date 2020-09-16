#!/bin/bash

# Record screen and audio with ffmpeg
# lu0

if pgrep ffmpeg
then
    notify-send -i "emblem-videos-symbolic" "Screencast" "Saved" 
    sleep 3 && pkill ffmpeg
else
    if zenity --question --text "Screencast" --ok-label="Start" --cancel-label="Cancel"
    then
        # Wait for dialog
        sleep 1 &&

        # Set name according to date and time
        mkdir -p $HOME/videos/screencast/
        NAME=("$HOME/videos/screencast/screencast-$(date +%y%m%d)-$(date +%H%M%S).mp4")

        # Get display resolution
        RES=$(xdpyinfo | grep dimensions | awk '{print $2}')
        
        # Start recording. Codecs chosen according to compatibility with android
        # ffmpeg -y -f x11grab -s $RES -r 30 -i :0.0 -f alsa -i pulse -c:v h264 -c:a aac -ac 2 -vf scale=out_color_matrix=bt709 -pix_fmt yuv420p -movflags faststart $NAME

        ffmpeg -y \
        -f x11grab -s $RES \
        -i :0.0 \
        -f alsa \
        -i pulse \
        -filter:a "volume=4.0" \
        -c:v h264 -vf scale=out_color_matrix=bt709 -pix_fmt yuv420p \
        -movflags faststart \
        -r 30 \
        -c:a aac -ac 2 $NAME
        
    fi
fi
