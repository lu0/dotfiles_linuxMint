#!/bin/bash

# Record screen and audio with ffmpeg
# lu0

# list recording devices:
# pacmd list-sources | awk '/index:/ {print $0}; /name:/ {print $0}; /device\.description/ {print $0}'
# pacmd list-sources | awk '/index:/ {print $0}; /name:/ {print $0}; /device\.description/ {print $0}' | awk -F"[<>]" '{print $2}'
#
# list active output devices:
# pacmd list-sink-inputs | awk '/index:/ {print $0}; /state:/ {print $0}; /sink:/ {print $0}'
# pacmd list-sink-inputs | awk '/index:/ {print $0}; /state:/ {print $0}; /sink:/ {print $0}' | awk -F"[<>]" '{print $2}'


if pgrep ffmpeg
then
    if zenity --question --text "Stop screencast?" --ok-label="Stop" --cancel-label="Cancel"
    then
        notify-send -i "emblem-videos-symbolic" "Screencast" "SAVED!!!" 
        sleep 3 && pkill ffmpeg
    fi

else
    # GET RESOLUTION AND OFFSET OF THE CURRENT SCREEN -------------------------------------
    # Based on Adam's solution: https://superuser.com/a/992924
    monitor_index=0
    OFFSET_REGEX="\+([-0-9]+)\+([-0-9]+)"
    eval "$(xdotool getmouselocation --shell)"
    while read name width height X_OFFSET Y_OFFSET
    # Loop through each screen and compare the offset with the window coordinates
    do
        if [ "${X}" -ge "$X_OFFSET" \
            -a "${Y}" -ge "$Y_OFFSET" \
            -a "${X}" -lt "$(($X_OFFSET+$width))" \
            -a "${Y}" -lt "$(($Y_OFFSET+$height))" ]
        then
            MONITOR=$name
            RESOLUTION=${width}x${height}
            break
        fi
        ((monitor_index++))
    done < <(xrandr | grep -w connected |
                sed -r "s/^([^ ]*).*\b([-0-9]+)x([-0-9]+)$OFFSET_REGEX.*$/\1 \2 \3 \4 \5/" | 
                sort -nk4,5)

    # Active audio output -------------------------------------------------------------------
    ACTIVE_OUTPUT=($(pacmd list-sink-inputs | awk '/index:/ {print $0}; /state:/ {print $0}; /sink:/ {print $0}' | awk -F"[<>]" '{print $2}'))
    ACTIVE_AUDIO_MONITOR="${ACTIVE_OUTPUT}.monitor"     # record what i listen

    # Microphone ----------------------------------------------------------------------------
    INT_MICROPHONE='alsa_input.pci-0000_00_1f.3.analog-stereo'
    # BT_HEADSET_SONY='bluez_sink.00_18_09_2E_74_B5.a2dp_sink.monitor'
    # BT_HEADSET_TT='bluez_sink.E8_07_BF_31_54_2C.a2dp_sink.monitor'

    # Message to be displayed on the zenity window ------------------------------------------
    INFO_MSG="Monitor:\t\t\t$MONITOR
              \t\t\tResolution:\t$RESOLUTION
              \t\t\tX, Y offset:\t$X_OFFSET, $Y_OFFSET
              \nAudio monitor:\t$ACTIVE_OUTPUT\nMicrophone:\t\t$INT_MICROPHONE\n"


    if SC_INPUT=$(zenity --entry --title="Screencast" --text="$INFO_MSG\nEnter the suffix for your new screencast" --ok-label="Start" --cancel-label="Cancel")
    then
        # Wait for dialog
        sleep 1 &&

        # Prepare path
        mkdir -p $HOME/videos/screencast/

        # Remove trailing spaces and add dashes between words
        SC_INPUT=$(echo $SC_INPUT | xargs | tr ' ' '-')

        if [ -n "$SC_INPUT" ]; then
            SC_NAME=("$HOME/videos/screencast/sc-$(date +%y%m%d)-$(date +%H%M%S)-${SC_INPUT}.mp4")
        else
            SC_NAME=("$HOME/videos/screencast/sc-$(date +%y%m%d)-$(date +%H%M%S).mp4")
        fi

        echo $SC_INPUT  # user input
        echo $SC_NAME   # complete path

        # START RECORDING
        # Codecs chosen to be compatible with android devices
        # The time taken to display the notification "Attempting" gives an idea of whether ffmpeg ran successfully or not.
        ffmpeg -y \
        -f x11grab -video_size $RESOLUTION -grab_x $X_OFFSET -grab_y $Y_OFFSET -i :0.0 \
        -f pulse -i $INT_MICROPHONE \
        -f pulse -i $ACTIVE_AUDIO_MONITOR \
        -filter_complex \
        "[1:a]volume=0.3[mic]; [2:a]volume=70.0[output]; \
        [mic][output]amix=inputs=2[a]" \
        -c:v h264 -vf scale=out_color_matrix=bt709 -pix_fmt yuv420p \
        -movflags faststart \
        -r 30 \
        -map 0:v -map "[a]" -c:a aac $SC_NAME || 
        notify-send -i "emblem-videos-symbolic" "Screencast" "Saving..."
        
    fi
fi
