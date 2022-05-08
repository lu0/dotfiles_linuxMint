#!/usr/bin/env bash

#
# This script toggles between states raised and minimized of a window,
# opens a new one if not present.
#
# - Arguments:
#   Properties of the program to open, defaults to Gnome Terminal:
#   - $1  Class the window of the program to toggle/open generates,
#       (1st element of the output of `xprop WM_CLASS`).
#   - $2  Class name the window of the program to toggle/open generates,
#       (2nd element of the output of `xprop WM_CLASS`).
#   - $3  Command of the program to toggle/open.
#   Configuration of gaps, useful when taskbars are present,
#   defaults to left taskbar of 36px width and shared gaps of 10px.
#   - $4 Width of left taskbar (px).
#   - $5 Width of right taskbar (px).
#   - $6 Height of top taskbar (px).
#   - $7 Height of bottom taskbar (px).
#   - $8 Size of shared gaps (px).
# - Libraries:
#   - display_info (from this same repo/folders)
#       Used to get the information of the current display
#
# https://github.com/lu0
#

declare -A PROGRAM=(
    ["class"]="${1:-"gnome-terminal-server"}"
    ["class_name"]="${2:-"Gnome-terminal"}"
    ["command"]="${3:-"gnome-terminal"}"
)

declare -A GAPS=(
    ["left"]="${4:-36}"
    ["right"]="${5:-0}"
    ["top"]="${6:-0}"
    ["bottom"]="${7:-0}"
    ["shared"]="${8:-10}"
)

# Valid with options -lGx
declare -A WMCTRL_COLS=(
    ["hex_win_id"]=1
    ["workspace"]=2
    ["x"]=3
    ["y"]=4
    ["width"]=5
    ["height"]=6
    ["class"]=7
    ["host"]=8
    ["title"]=9-
)

# Gets the ID of the first window whose Class matches the target one.
# - Globals:
#   - $PROGRAM      Hashmap with properties of the program to open.
#   - $WMCTRL_COLS  Hashmap with properties returned by `wmctrl -lGx`.
# - Returns:
#   - ID of the window in hex format 0x00000000 if exists, blank if it doesn't.
wmctrl::get_window_id() {
    local class_wmctrl_format="${PROGRAM[class]}.${PROGRAM[class_name]}"
    wmctrl -lGx \
        | grep -w "${class_wmctrl_format}" \
        | head -1 \
        | cut -d' ' -f"${WMCTRL_COLS[hex_win_id]}"
}

# Parses property of a window using wmctrl
# - Args:
#   - $1  property key from hashmap WMCTRL_COLS.
#   - $2  hexadecimal window ID in format 0x00000000.
wmctrl::get_prop_of_win_id() {
    local prop="${1}"
    local hex_win_id="${2}"
    wmctrl -lGx | tr -s ' ' \
        | grep -w "${hex_win_id}" | cut -d' ' -f"${WMCTRL_COLS[${prop}]}"
}


# Centers the mouse in a window given the window's ID
# - Args:
#   - $1  hexadecimal window ID in format 0x00000000.
# shellcheck disable=SC2155 # enable oneliner assignments and declarations
mouse::center_in_window() {
    local hex_win_id="${1}"
    local x=$(wmctrl::get_prop_of_win_id "x" "${hex_win_id}")
    local y=$(wmctrl::get_prop_of_win_id "y" "${hex_win_id}")
    local width=$(wmctrl::get_prop_of_win_id "width" "${hex_win_id}")
    local height=$(wmctrl::get_prop_of_win_id "height" "${hex_win_id}")
    xdotool mousemove $(( width/2 + x )) $(( height/2 + y ))
}

# Centers the mouse in a display given the display's info
# - Globals:
#   - $DISPLAY_INFO  hashmap from library `display_info`
mouse::center_in_display() {
    local x="${DISPLAY_INFO[x]}"
    local y="${DISPLAY_INFO[y]}"
    local width="${DISPLAY_INFO[width]}"
    local height="${DISPLAY_INFO[height]}"
    xdotool mousemove $(( width/2 + x )) $(( height/2 + y ))
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

# Gets the window id of the active window in hexadecimal format
window::get_active_id() {
    utils::dec_to_hex "$(xdotool getactivewindow)"
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

# Moves a window to the active display given the window id
# - Args:
#   - $1                hexadecimal window ID in format 0x00000000.
# - Globals:
#   - $GAPS             Hashmap with configuration of gaps.
#   - $DISPLAY_INFO     hashmap from library `display_info`
window::move_to_active_display() {
    local hex_win_id="${1}"
    local x=$(( DISPLAY_INFO[x] + GAPS[left] + GAPS[shared] ))
    local y=$(( DISPLAY_INFO[y] + GAPS[top] + GAPS[shared] ))
    local width=$(( DISPLAY_INFO[width] - GAPS[left] - GAPS[right] - GAPS[shared]*2 ))
    local height=$(( DISPLAY_INFO[height] - GAPS[top] - GAPS[bottom] - GAPS[shared]*2 ))

    wmctrl -i -r "${hex_win_id}" -b remove,maximized_horz,maximized_vert && \
    wmctrl -i -r "${hex_win_id}" -e 0,${x},${y},${width},${height}
}

# Moves a window to the active workspace given the window id
# - Args:
#   - $1  hexadecimal window ID in format 0x00000000.
# shellcheck disable=SC2155 # enable oneliner assignments and declarations
window::move_to_active_workspace() {
    local target_hex_win_id="${1}"
    local active_hex_win_id="$(window::get_active_id)"
    local active_workspace="$(
        wmctrl::get_prop_of_win_id "workspace" "${active_hex_win_id}"
    )"
    wmctrl -i -r "${target_hex_win_id}" -t "${active_workspace}"
}

# Raises a window given its ID by moving it to the current workspace,
# activating it and then centering the mouse in it.
# - Arguments:
#   - $1  hexadecimal Window ID in format 0x00000000 .
window::raise() {
    local hex_win_id="${1}"

    # Returns DISPLAY_INFO
    display_info::store

    mouse::center_in_display
    window::move_to_active_display "${hex_win_id}"
    window::move_to_active_workspace "${hex_win_id}"
    xdotool windowactivate "$(utils::hex_to_dec "${hex_win_id}")"
}

# Minimizes a window given its ID.
# - Arguments:
#   - $1  hexadecimal number in format 0x00000000 .
window::hide() {
    xdotool windowminimize "$(utils::hex_to_dec "${1}")"
}

# Decides whether to raise (if hidden) or hide (if activated) a window.
# - Globals:
#   - $PROGRAM  Hashmap with properties of the program to open a window for.
window::toggle() {
    if window::exists ; then
        hex_win_id=$(wmctrl::get_window_id)
        if window::is_active ; then
            window::hide "${hex_win_id}"
        else
            window::raise "${hex_win_id}"
        fi
    else
        window::open "${PROGRAM[command]}"
        hex_win_id=$(wmctrl::get_window_id)
        window::raise "${hex_win_id}"
    fi
}

# import_libs
script_abs_file_path=$(readlink -f "$(which "${BASH_SOURCE[0]}")")
script_abs_dir_path=$(dirname ${script_abs_file_path})

source "${script_abs_dir_path}/display_info.sh"

# Run main
window::toggle
