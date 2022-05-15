#!/usr/bin/env bash

if [ "$0" == "${BASH_SOURCE[0]}" ]; then
    echo "script intended to be sourced instead of executed."
    exit 1
fi

script_abs_file_path=$(readlink -f "${BASH_SOURCE[0]}")
script_abs_dir_path=$(dirname "${script_abs_file_path}")

# shellcheck source=scripts/window-control/utils.sh
source "${script_abs_dir_path}/utils.sh"

# shellcheck source=scripts/window-control/current-x-display-info/display_info.sh
source "${script_abs_dir_path}/current-x-display-info/display_info.sh"

# shellcheck source=scripts/window-control/gaps.sh
source "${script_abs_dir_path}/gaps.sh"
