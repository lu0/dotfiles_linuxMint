#!/usr/bin/env bash

# 
# This script gets information of the current display,
# the one the mouse is located in.
# 
# Can be used as a library by sourcing it from another script.
# 
# https://github.com/lu0
# 

declare -A DISPLAY_INFO;                declare -a INFO_SORTING
DISPLAY_INFO["monitor_name"]="";        INFO_SORTING+=("monitor_name")            
DISPLAY_INFO["resolution"]="";          INFO_SORTING+=("resolution")        
DISPLAY_INFO["x"]="";                   INFO_SORTING+=("x")
DISPLAY_INFO["y"]="";                   INFO_SORTING+=("y")
DISPLAY_INFO["width"]="";               INFO_SORTING+=("width")    
DISPLAY_INFO["height"]="";              INFO_SORTING+=("height")    
DISPLAY_INFO["window_id"]="";           INFO_SORTING+=("window_id")        

# Show hashmap DISPLAY_INFO in the order specified by array INFO_SORTING
display_info::show() {
    for i in "${INFO_SORTING[@]}"; do
        echo "${DISPLAY_INFO[${i}]}"
    done
}

# Fill hashmap DISPLAY_INFO
display_info::store() {
    # Regex to match all contiguous numbers
    nums_re="[0-9]+"

    # Regex to match lines [xres]x[yres]+[xoffset]+[yoffset]
    complete_re="^${nums_re}x${nums_re}\+${nums_re}\+${nums_re}$"
    #            │          │           │   match end of line ─┘
    #            │          │           └ + scaped (offset separator)
    #            │          └─ x (resolution separator)
    #            └─ match start of line

    # Evaluates to variables X, Y, SCREEN, WINDOW
    eval "$(xdotool getmouselocation --shell)"
    DISPLAY_INFO[window_id]="${WINDOW}"

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
           [ "${Y}" -ge "${off_y}" ] && [ "${Y}" -lt "$(( off_y + res_y ))" ];
        then
            DISPLAY_INFO[monitor_name]="${monitor_names_array[monitor_index]}"
            DISPLAY_INFO[resolution]="${res_x}x${res_y}"

            DISPLAY_INFO[width]="${res_x}"
            DISPLAY_INFO[height]="${res_y}"
            DISPLAY_INFO[x]="${off_x}"
            DISPLAY_INFO[y]="${off_y}"
            break
        fi

        (( monitor_index++ ))
    done
}


if [[ "${#BASH_SOURCE[@]}" -eq 1 ]]; then
    display_info::store
    display_info::show
fi
