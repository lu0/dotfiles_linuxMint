#!/usr/bin/env bash

declare -A XWININFO=(
    ["x"]="Absolute upper-left X"
    ["y"]="Absolute upper-left Y"
    ["width"]="Width"
    ["height"]="Height"
)

# Parses numerical property of a window using `xwininfo`
# - Args:
#   - $1  property key from hashmap XWININFO (x, y, width or height)
#   - $2  hexadecimal window ID in format 0x00000000.
# shellcheck disable=SC2155 # enable oneliner assignments and declarations
utils::get_window_property() {
    local prop="${1}"
    local hex_win_id="${2}"
    local dec_win_id=$(utils::hex_to_dec "${hex_win_id}")
    xwininfo -id "${dec_win_id}" | grep "${XWININFO[${prop}]}" | grep -Po "[0-9]+"
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

# Gets the ID of the active window in hexadecimal format
utils::get_active_hex_window_id() {
    utils::dec_to_hex "$(xdotool getactivewindow)"
}

# Gets the ID of the active window in decimal format
utils::get_active_dec_window_id() {
    xdotool getactivewindow
}


if [[ "${#BASH_SOURCE[@]}" -eq 1 ]]; then
    active_hex_win_id=$(utils::get_active_hex_window_id)
    active_dec_win_id=$(utils::hex_to_dec "${active_hex_win_id}")
    echo "Window ID in hex format converted from dec: ${active_hex_win_id}"
    echo "Window ID in dec format converted from hex: ${active_dec_win_id}"

    win_x=$(utils::get_window_property "x" "${active_hex_win_id}")
    win_y=$(utils::get_window_property "y" "${active_hex_win_id}")
    win_w=$(utils::get_window_property "width" "${active_hex_win_id}")
    win_h=$(utils::get_window_property "height" "${active_hex_win_id}")
    echo "Window ${active_hex_win_id} is located at (x: ${win_x}, y: ${win_y})"
    echo "Window ${active_hex_win_id} has width ${win_w} and height ${win_h})"
fi
