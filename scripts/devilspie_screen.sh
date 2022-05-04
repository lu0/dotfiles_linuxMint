#!/usr/bin/env bash

# GET RESOLUTION AND OFFSET OF THE CURRENT SCREEN -------------------------------------
# Based on Adam's solution: https://superuser.com/a/992924

# Regex to match all contiguous numbers
readonly nums_re="[0-9]+"

# Regex to match lines [xres]x[yres]+[xoffset]+[yoffset]
readonly complete_re="^${nums_re}x${nums_re}\+${nums_re}\+${nums_re}$"
#                     │          │           │   match end of line ─┘
#                     │          │           └ + scaped (offset separator)
#                     │          └─ x (resolution separator)
#                     └─ match start of line

# Evaluates to variables X, Y, SCREEN, WINDOW
eval "$(xdotool getmouselocation --shell)"

all_props=$(xrandr | grep -w connected | awk '{OFS="\n"; $1=$1}1')
dimensions=$(echo -e "${all_props}" | grep -Po "${complete_re}")

# shellcheck disable=2207
# Command output unquoted to enable splitting
monitor_names=($(xrandr | grep -w connected | cut -d' ' -f1))

monitor_index=0
for dim in ${dimensions}; do
    # shellcheck disable=2207
    # Command output unquoted to enable splitting
    dim_numbers_only=($(echo "${dim}" | grep -Po "${nums_re}"))

    res_x="${dim_numbers_only[0]}"
    res_y="${dim_numbers_only[1]}"
    off_x="${dim_numbers_only[2]}"
    off_y="${dim_numbers_only[3]}"

    if [ "${X}" -ge "$off_x" ] && \
       [ "${Y}" -ge "$off_y" ] && \
       [ "${X}" -lt "$(( $off_x + $res_x ))" ] && \
       [ "${Y}" -lt "$(( $off_y + $res_y ))" ]
    then
        monitor="${monitor_names[monitor_index]}"
        resolution="${res_x}x${res_y}"
        break
    fi
    (( monitor_index++ ))
done

echo -e "Sending variables to lua..."
echo -e "$monitor\n"
echo -e "$resolution\n"
echo -e "$off_x"
echo -e "$off_y\n"
echo -e "$res_x"
echo -e "$res_y"
