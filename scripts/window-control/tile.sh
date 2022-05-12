#!/usr/bin/env bash
# shellcheck disable=SC2155

#
# This script tiles a window in the specified position.
#
# - Args:
#   - $1    Desired position, given by the name of the tile function:
#           bottom, bottom_left, bottom_right, left, right, ..., etc.
# - Requires globals:
#   - $DISPLAY_INFO  Hashmap with information of the current display,
#                    retrieved from custom library `display_info.sh`
#   - $GAPS          Hashmap with the configuration of gaps,
#                    retrieved from custom library `gaps.sh`
#

# Dimensions ==================================================================

# Returns entire width for tiles after accounting for gaps
width::fill() {
    echo $(( DISPLAY_INFO[width] - GAPS[left] - GAPS[right] - GAPS[shared]*2 ))
}

# Returns half width for tiles after accounting for gaps
width::half() {
    width=$(width::fill)
    echo $(( ( width - GAPS[shared] )/2 ))
}

# Returns entire height for tiles after accounting for gaps
height::fill() {
    echo $(( DISPLAY_INFO[height] - GAPS[top] - GAPS[bottom] - GAPS[shared]*2 ))
}

# Returns half height for tiles after accounting for gaps
height::half() {
    height=$(height::fill)
    echo $(( ( height - GAPS[shared] )/2 ))
}

# Coordinates =================================================================

# Returns x coordinate for tiles in the left section of the display
x::left() {
    echo $(( DISPLAY_INFO[x] + GAPS[left] + GAPS[shared]*1 ))
}

# Returns x coordinate for tiles in the right section of the display
x::right() {
    half_width=$(width::half)
    echo $(( DISPLAY_INFO[x] + GAPS[left] + half_width + GAPS[shared]*2 ))
}

# Returns y coordinate for tiles in the top section of the display
y::top() {
    echo $(( DISPLAY_INFO[y] + GAPS[top] + GAPS[shared]*1 ))
}

# Returns y coordinate for tiles in the bottom section of the display
y::bottom() {
    half_height=$(height::half)
    echo $(( DISPLAY_INFO[y] + GAPS[top] + half_height + GAPS[shared]*2 ))
}

# Tiling functions ============================================================

tile::bottom() {
    wmctrl -ir "${1}" -e 0,"$(x::left),$(y::bottom),$(width::fill),$(height::half)"
    utils::center_mouse_in_window "${1}"
}

tile::bottom_left() {
    wmctrl -ir "${1}" -e 0,"$(x::left),$(y::bottom),$(width::half),$(height::half)"
    utils::center_mouse_in_window "${1}"
}

tile::bottom_right() {
    wmctrl -ir "${1}" -e 0,"$(x::right),$(y::bottom),$(width::half),$(height::half)"
    utils::center_mouse_in_window "${1}"
}

tile::left() {
    wmctrl -ir "${1}" -e 0,"$(x::left),$(y::top),$(width::half),$(height::fill)"
    utils::center_mouse_in_window "${1}"
}

tile::right() {
    wmctrl -ir "${1}" -e 0,"$(x::right),$(y::top),$(width::half),$(height::fill)"
    utils::center_mouse_in_window "${1}"
}

tile::top() {
    wmctrl -ir "${1}" -e 0,"$(x::left),$(y::top),$(width::fill),$(height::half)"
    utils::center_mouse_in_window "${1}"
}

tile::top_left() {
    wmctrl -ir "${1}" -e 0,"$(x::left),$(y::top),$(width::half),$(height::half)"
    utils::center_mouse_in_window "${1}"
}

tile::top_right() {
    wmctrl -ir "${1}" -e 0,"$(x::right),$(y::top),$(width::half),$(height::half)"
    utils::center_mouse_in_window "${1}"
}

tile::maximize() {
    wmctrl -ir "${1}" -e 0,"$(x::left),$(y::top),$(width::fill),$(height::fill)"
    utils::center_mouse_in_window "${1}"
}

snap::remove() {
    # If the window is tiled or snapped by the built-in window manager, it
    # cannot be resized or positioned (at least in Cinnamon, which use muffin),
    # hence we try to unsnap the window by removing the following properties:
    wmctrl -ir "${1}" -b remove,fullscreen,maximized_horz,maximized_vert
}

# Main function
# - Args:
#   - $1  Tile function to evaluate
main() {
    local hex_win_id=$(utils::get_active_hex_window_id)
    snap::remove "${hex_win_id}"
    tile::"${1}" "${hex_win_id}"
}


if [[ "${#BASH_SOURCE[@]}" -eq 1 ]]; then
    # Import libs =============================================================
    # shellcheck disable=SC2230
    script_abs_file_path=$(readlink -f "$(which "${BASH_SOURCE[0]}")")
    script_abs_dir_path=$(dirname "${script_abs_file_path}")

    # shellcheck source=scripts/window-control/_load_common_libs.sh
    source "${script_abs_dir_path}/_load_common_libs.sh"

    gaps::load
    display_info::load

    # Tile ====================================================================
    main "${1}"
fi
