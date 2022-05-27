#!/usr/bin/env bash

# Manage battery on ThinkPads
alias battery="sudo tlp-stat -b"
alias fullcharge="sudo tlp fullcharge"

# Redirect microphone to speaker
alias mic2speaker-on="pactl load-module module-loopback latency_msec=1"
alias mic2speaker-off="pactl unload-module module-loopback"

# Reload mediakeys, sometimes they get confused with youtube/spotify
alias mediakeys="killall csd-media-keys; csd-media-keys & disown"

# Restart Cinnamon DE, useful when developing applets, themes, etc.
alias cinnamon-restart="cinnamon --replace --display=:0"

# Check if automatic shutdown is set
shutdown-show() {
    local unix_timestamp human_timestamp
    local file=/run/systemd/shutdown/scheduled
    if [ -f "${file}" ]; then
        unix_timestamp=$(grep "USEC" "${file}" | cut -d'=' -f2 | cut -c -10)
        human_timestamp=$(date -d @"${unix_timestamp}")
        echo "Shutdown scheduled for ${human_timestamp},"
        echo "use 'shutdown -c' to cancel."
    else
        echo "Automatic shutdown is not set."
    fi
}

# Manage automatic wakeup / boot
wakeup() {
    local alarm_file="/sys/class/rtc/rtc0/wakealarm"

    _show_usage() {
        echo -e "\nManage automatic wakeup (power-on/boot)."
        echo -e "\nUSAGE:"
        echo -e "   wakeup   [OPTIONS] ARGUMENTS"
        echo -e "\nOPTIONS:"
        echo -e "       -a      Show current wakeup alarm."
        echo -e "       -c      Clear wakeup alarm."
        echo -e "       -s      Set wakeup alarm:"
        echo -e "                wakeup -s <time_HHmm> <plus_days>"
        echo -e "                wakeup -s 2330 1 # tomorrow at 11:30pm\n"
    }

    _clear_alarm() {
      sudo sh -c "echo 0 > ${alarm_file}"
    }

    _set_alarm() {
        local wakeup_epoch="${1}"
        sudo sh -c "echo ${wakeup_epoch} > ${alarm_file}"
    }

    _show_alarm() {
        local unix_timestamp
        unix_timestamp=$(cat ${alarm_file})
        if [ "${unix_timestamp}" ]; then
            local human_timestamp
            human_timestamp=$(date -d @"${unix_timestamp}")
            echo "Wakeup scheduled for ${human_timestamp},"
            echo "use 'wakeup -c' to cancel."
        else
            echo "Automatic wakeup is not set."
        fi
    }

    OPTIND=1 # Reset getops
    while getopts acs opt; do
        case "${opt}" in
            a)
                _show_alarm
                ;;
            c)
                _clear_alarm
                _show_alarm
                ;;
            s)
                local wakeup_time_hhmm="${2:-0655}"
                local delay_days="${3:-1}"

                local wakeup_day wakeup_epoch
                wakeup_day=$(date -d "+${delay_days} day" +"%Y%m%d")
                wakeup_epoch=$(date -d "${wakeup_day} ${wakeup_time_hhmm}" +%s)

                _clear_alarm
                _set_alarm "${wakeup_epoch}"
                _show_alarm
                ;;
            *)
                _show_usage
                ;;
        esac
    done
}
