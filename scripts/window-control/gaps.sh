#!/usr/bin/env bash

#
# Loads configuration of Gaps from `gaps.conf`
#

declare -A GAPS
GAPS["left"]=-""
GAPS["right"]=""
GAPS["top"]=""
GAPS["bottom"]=""
GAPS["shared"]=-""

# Shows hashmap GAPS
gaps::show() {
    local value
    echo >&2 -e "GAPS:\n"
    for key in "${!GAPS[@]}"; do
        value="${GAPS[${key}]}"
        echo "${key}=${value}"
    done
}

# Fills hashmap GAPS
# shellcheck disable=SC2154
gaps::load() {
    script_abs_file_path=$(readlink -f "${BASH_SOURCE[0]}")
    script_abs_dir_path=$(dirname "${script_abs_file_path}")

    # shellcheck source=scripts/window-control/gaps.conf
    source "${script_abs_dir_path}"/gaps.conf

    GAPS["left"]="${left}"
    GAPS["right"]="${right}"
    GAPS["top"]="${top}"
    GAPS["bottom"]="${bottom}"
    GAPS["shared"]="${shared}"
}


if [[ "${#BASH_SOURCE[@]}" -eq 1 ]]; then
    gaps::load
    gaps::show
fi
