#!/bin/bash

#
# Maximizes a window (with gaps)
#
# - Libraries:
#   - gaps (from this same repo/folders)
#       Loads configuration of gaps from `gaps.conf`.
#   - display_info (from this same repo/folders)
#       Gets the information of the current display.
#

# Maximizes a window (with gaps) in the active display given the window id
# - Args:
#   - $1                hexadecimal window ID in format 0x00000000.
# - Assumes loaded variables:
#   - $GAPS             hashmap from library `gaps`
#   - $DISPLAY_INFO     hashmap from library `display_info`
# shellcheck disable=SC2155 # enable oneliner assignments and declarations
maximize::by_id_assume_loaded_info() {
    local hex_win_id="${1}"
    local x=$(( DISPLAY_INFO[x] + GAPS[left] + GAPS[shared]*1 ))
    local y=$(( DISPLAY_INFO[y] + GAPS[top] + GAPS[shared]*1 ))
    local width=$(( DISPLAY_INFO[width] - GAPS[left] - GAPS[right] - GAPS[shared]*2 ))
    local height=$(( DISPLAY_INFO[height] - GAPS[top] - GAPS[bottom] - GAPS[shared]*2 ))

    # Windows tiled or snapped by built-in window managers cannot be
    # resized or moved, hence we remove those properties.
    wmctrl -ir "${hex_win_id}" -b remove,fullscreen
    wmctrl -ir "${hex_win_id}" -b remove,maximized_horz,maximized_vert

    wmctrl -ir "${hex_win_id}" -e 0,${x},${y},${width},${height}
}

maximize::standalone() {
    gaps::load
    display_info::load
    active_hex_win_id="$(utils::get_active_hex_window_id)"
    maximize::by_id_assume_loaded_info "${active_hex_win_id}"
}

if [[ "${#BASH_SOURCE[@]}" -eq 1 ]]; then
    # Import libs =============================================================
    # shellcheck disable=SC2230
    script_abs_file_path=$(readlink -f "$(which "${BASH_SOURCE[0]}")")
    script_abs_dir_path=$(dirname "${script_abs_file_path}")

    # shellcheck source=scripts/window-control/_load_common_libs.sh
    source "${script_abs_dir_path}/_load_common_libs.sh"

    # Run main ================================================================
    maximize::standalone
fi
