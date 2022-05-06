#!/usr/bin/env bash

#
# This script toggles between states raised and minimized of a window,
# opens a new one if not present.
# 
# - Arguments:
#   Properties of the program to open (defaults to Gnome Terminal):
#   - $1  Class the window of the program to toggle/open generates,
#       (1st element of the output of `xprop WM_CLASS`).
#   - $2  Class name the window of the program to toggle/open generates,
#       (2nd element of the output of `xprop WM_CLASS`).
#   - $3  Command of the program to toggle/open.
# 
# https://github.com/lu0
#

declare -A PROGRAM=(
    ["class"]="${1:-"gnome-terminal-server"}"
    ["class_name"]="${2:-"Gnome-terminal"}"
    ["command"]="${3:-"gnome-terminal"}"
)

# Valid with options -lGx
declare -A WMCTRL_COLS=(
    ["hex_window_id"]=1
    ["workspace"]=2
    ["x"]=3
    ["y"]=4
    ["width"]=5
    ["height"]=6
    ["class"]=7
    ["host"]=8
    ["title"]=9-
)

# Parses property of a window using wmctrl
# - Args:
#   - $1  property key from hashmap WMCTRL_COLS.
#   - $2  hexadecimal window ID in format 0x00000000.
wmctrl::get_prop_of_window_id() {
    local prop="${1}"
    local hex_window_id="${2}"
    wmctrl -lGx | tr -s ' ' \
        | grep -w "${hex_window_id}" | cut -d' ' -f"${WMCTRL_COLS[${prop}]}"
}

# Converts a decimal number to its hexadecimal representation.
# - Arguments:
#   - $1  decimal number.
# - Returns:
#   - hexadecimal representation with 8 leading 0s: 0x00000000 .
utils::dec_to_hex() {
    printf '0x%08x\n' "${1}"
}

# Converts an hexadecimal number to its decimal representation.
# - Arguments:
#   - $1  hexadecimal number.
# - Returns:
#   - decimal representation of the number.
utils::hex_to_dec() {
    printf "%d\n" "${1}"
}


# Gets class property of the currently active window.
window::get_active_xprop_class() {
    xprop -id "$(xdotool getactivewindow)" WM_CLASS
}

# Checks if a window exists by looking for its class property
# in the information of the X Window Manager (wmctrl).
# - Globals:
#   - $PROGRAM  Hashmap with properties of the program to open.
# - Returns:
#   - 0 if the window exists, non-zero on error.
window::exists() {
    wmctrl -lGx | grep -wq "${PROGRAM[class]}.${PROGRAM[class_name]}"
}

# Checks if a window is active (raised and focused) by comparing
# its class property with the class property of the program to open.
# Globals:
#   $PROGRAM  Hashmap with properties of the program to open.
# Returns:
#   0 if the window exists, 1 if it doesn't.
window::is_active() {
    local class_xprop=(
        "WM_CLASS(STRING) ="
        "\"${PROGRAM[class]}\","
        "\"${PROGRAM[class_name]}\""
    )
    if [[ "${class_xprop[*]}" == "$(window::get_active_xprop_class)" ]]; then
        return 0
    else
        return 1
    fi
}

# Opens a new window by issuing its command.
# - Arguments:
#   - $1  command to run.
window::open() {
    local command_to_open="${1}"
    $command_to_open
}

# Activates a window given its ID.
# This also centers the mouse in it.
# - Arguments:
#   - $1  hexadecimal Window ID in format 0x00000000 .
# shellcheck disable=SC2155 # enable oneliner local assignments
window::raise() {
    local hex_window_id="${1}"
    local x=$(wmctrl::get_prop_of_window_id "x" "${hex_window_id}")
    local y=$(wmctrl::get_prop_of_window_id "y" "${hex_window_id}")
    local width=$(wmctrl::get_prop_of_window_id "width" "${hex_window_id}")
    local height=$(wmctrl::get_prop_of_window_id "height" "${hex_window_id}")
    xdotool windowactivate "$(utils::hex_to_dec "${hex_window_id}")"
    xdotool mousemove $(( width/2 + x )) $(( height/2 + y ))
}

# Minimizes a window given its ID.
# - Arguments:
#   - $1  hexadecimal number in format 0x00000000 .
window::hide() {
    xdotool windowminimize "$(utils::hex_to_dec "${1}")"
}

# Gets the ID of the first window whose Class matches the target one.
# - Globals:
#   - $PROGRAM  Hashmap with properties of the program to open.
# - Returns:
#   - ID of the window in hex format 0x00000000 if exists, blank if it doesn't.
window::get_target_id() {
    local class_wmctrl_format="${PROGRAM[class]}.${PROGRAM[class_name]}"
    wmctrl -lGx \
        | grep -w "${class_wmctrl_format}" \
        | head -1 \
        | cut -d' ' -f"${WMCTRL_COLS[hex_window_id]}"
}

# Decides whether to raise (if hidden) or hide (if activated) a window.
# - Globals:
#   - $PROGRAM  Hashmap with properties of the program to open a window for.
window::toggle() {
    if window::exists ; then
        hex_window_id=$(window::get_target_id)
        if window::is_active ; then
            window::hide "${hex_window_id}"
        else
            window::raise "${hex_window_id}"
        fi
    else
        window::open "${PROGRAM[command]}"
    fi
}

window::toggle
