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
#
# https://github.com/lu0
#

declare -A PROGRAM=(
    ["class"]="${1:-"gnome-terminal-server"}"
    ["class_name"]="${2:-"Gnome-terminal"}"
    ["command"]="${3:-"gnome-terminal"}"
)

# Gets the ID of the first window whose Class matches the target one.
# - Globals:
#   - $PROGRAM      Hashmap with properties of the program to open.
# - Returns:
#   - ID of the window in hex format 0x00000000 if exists, blank if it doesn't.
wmctrl::get_window_id() {
    local class_wmctrl_format="${PROGRAM[class]}.${PROGRAM[class_name]}"
    wmctrl -lGx \
        | grep -w "${class_wmctrl_format}" \
        | head -1 \
        | cut -d' ' -f1
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

# Moves a window to the active display by maximizing it
# if the display in which the window is located is not the active one.
# - Args:
#   - $1                hexadecimal window ID in format 0x00000000.
# - Globals required:
#   - $GAPS             hashmap from library `gaps`
#   - $DISPLAY_INFO     hashmap from library `utils::load_display_info`
# shellcheck disable=SC2155 # enable oneliner assignments and declarations
window::move_to_and_maximize_in_active_display() {
    local hex_win_id="${1}"

    local win_xi=$(utils::get_window_property "x" "${hex_win_id}")
    local win_yi=$(utils::get_window_property "y" "${hex_win_id}")
    local win_width=$(utils::get_window_property "width" "${hex_win_id}")
    local win_height=$(utils::get_window_property "height" "${hex_win_id}")
    local win_xf=$(( win_xi + win_width ))
    local win_yf=$(( win_yi + win_height ))

    local display_xi="${DISPLAY_INFO[x]}"
    local display_yi="${DISPLAY_INFO[y]}"
    local display_width="${DISPLAY_INFO[width]}"
    local display_height="${DISPLAY_INFO[height]}"
    local display_xf=$(( display_xi + display_width ))
    local display_yf=$(( display_yi + display_height ))

    if ! { \
        [ "${win_xi}" -ge "${display_xi}" ] && \
        [ "${win_yi}" -ge "${display_yi}" ] && \
        [ "${win_xf}" -le "${display_xf}" ] && \
        [ "${win_yf}" -le "${display_yf}" ] ; \
    }; then
        tile::maximize "${hex_win_id}"
    fi
}

# Moves a window to the active workspace given the window id
# - Args:
#   - $1  hexadecimal window ID in format 0x00000000.
# shellcheck disable=SC2155 # enable oneliner assignments and declarations
window::move_to_active_workspace() {
    local target_hex_win_id="${1}"
    local target_dec_win_id="$(utils::hex_to_dec "${target_hex_win_id}")"
    local active_workspace=$(xdotool get_desktop)
    wmctrl -ir "${target_hex_win_id}" -t "${active_workspace}"
    
    for _ in {1..500}; do
        window_workspace=$(xdotool get_desktop_for_window "${target_dec_win_id}")
        [[ "${window_workspace}" == "${active_workspace}" ]] && return 0
        sleep 0.001
    done
    logger -t toggle_program_window.sh "Move failed: ${target_hex_win_id} -> ${active_workspace}"
    exit 1
}

# Raises a window given its ID by moving it to the current workspace,
# activating it and then centering the mouse in it.
# - Arguments:
#   - $1  hexadecimal Window ID in format 0x00000000 .
window::raise() {
    local hex_win_id="${1}"
    gaps::load
    utils::load_display_info
    window::move_to_and_maximize_in_active_display "${hex_win_id}"
    window::move_to_active_workspace "${hex_win_id}"
    xdotool windowactivate "$(utils::hex_to_dec "${hex_win_id}")"
    utils::center_mouse_in_window "${hex_win_id}"
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

# Import libs =================================================================
# shellcheck disable=SC2230
script_abs_file_path=$(readlink -f "$(which "${BASH_SOURCE[0]}")")
script_abs_dir_path=$(dirname "${script_abs_file_path}")

# shellcheck source=scripts/window-control/_load_common_libs.sh
source "${script_abs_dir_path}/_load_common_libs.sh"

# shellcheck source=scripts/window-control/tile.sh
source "${script_abs_dir_path}/tile.sh"

# Run main ====================================================================
window::toggle
