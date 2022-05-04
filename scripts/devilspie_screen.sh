#!/usr/bin/env bash

# 
# This script gets information of the current monitor
# 

# Regex to match all contiguous numbers
nums_re="[0-9]+"

# Regex to match lines [xres]x[yres]+[xoffset]+[yoffset]
complete_re="^${nums_re}x${nums_re}\+${nums_re}\+${nums_re}$"
                    # │          │           │   match end of line ─┘
                    # │          │           └ + scaped (offset separator)
                    # │          └─ x (resolution separator)
                    # └─ match start of line

# Evaluates to variables X, Y, SCREEN, WINDOW
eval "$(xdotool getmouselocation --shell)"

# shellcheck disable=2207 # Command unquoted to enable splitting
monitor_names_array=( $(xrandr | grep -w connected | cut -d' ' -f1) )

# Assumes sorting of `xrandr | grep -w connected` to be consistent (alphabetic)
props_split_to_lines="$(xrandr | grep -w connected | awk '{OFS="\n"; $1=$1}1')"
dimension_rows=$(echo -e "${props_split_to_lines}" | grep -Po "${complete_re}")

monitor_index=0
for dim in ${dimension_rows}; do
    # shellcheck disable=2207 # Command unquoted to enable splitting
    dimension_cols_array=( $(echo "${dim}" | grep -Po "${nums_re}") )
    res_x="${dimension_cols_array[0]}"
    res_y="${dimension_cols_array[1]}"
    off_x="${dimension_cols_array[2]}"
    off_y="${dimension_cols_array[3]}"

    if [ "${X}" -ge "${off_x}" ] && [ "${X}" -lt "$(( off_x + res_x ))" ] && \
       [ "${Y}" -ge "${off_y}" ] && [ "${Y}" -lt "$(( off_y + res_y ))" ]
    then
        monitor_name="${monitor_names_array[monitor_index]}"
        resolution="${res_x}x${res_y}"
        break
    fi

    (( monitor_index++ ))
done

echo -e "Sending variables to lua..."
echo -e "$monitor_name"
echo -e "$resolution"
echo -e "$off_x"
echo -e "$off_y"
echo -e "$res_x"
echo -e "$res_y"
