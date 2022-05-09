#!/usr/bin/env bash

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
fi
