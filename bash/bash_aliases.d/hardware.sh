#!/usr/bin/env bash

alias battery="sudo tlp-stat -b"
alias fullcharge="sudo tlp fullcharge"

alias mic2speaker-on="pactl load-module module-loopback latency_msec=1"
alias mic2speaker-off="pactl unload-module module-loopback"

alias mediakeys="killall csd-media-keys; csd-media-keys & disown"
alias cinnamon-restart="cinnamon --replace --display=:0"

# Check shutdown status
function shutdown-show() {
    if [ -f /run/systemd/shutdown/scheduled ]; then
        SHUTTIME=$(cat /run/systemd/shutdown/scheduled | grep "USEC" | cut -d '=' -f 2 | cut -c -10)
        echo "Shutdown scheduled for $(date -d @$SHUTTIME), use 'shutdown -c' to cancel."
    fi
}

function wakeup() {
    OPTIND=1 # Reset getops
    while getopts "acsd" opt; do
        case $opt in
        a)
            ALARM=$(cat /sys/class/rtc/rtc0/wakealarm)
            if [ $ALARM ]; then
                echo "Wakeup scheduled for $(date -d @$ALARM), use 'wakeup -c' to cancel."
            fi
            ;;
        c)
            sudo sh -c "echo 0 > /sys/class/rtc/rtc0/wakealarm" # Clear alarm
            echo -e "Wakeup canceled"
            ;;
        s)
            HOUR=$2 # HHMM
            DAY_DELAY=$3

            # Set date and time for wakeup alarm
            DATE=$(date -d "+$DAY_DELAY day" +"%Y%m%d") # Tomorrow, YYYMMDD
            WAKETIME=$(date -d "$DATE $HOUR" +%s)       # Convert to epoch

            sudo sh -c "echo 0 > /sys/class/rtc/rtc0/wakealarm"         # Clear alarm
            sudo sh -c "echo $WAKETIME > /sys/class/rtc/rtc0/wakealarm" # Set alarm
            ;;
        esac
    done
    unset ALARM HOUR DAY_DELAY DATE WAKETIME
}
