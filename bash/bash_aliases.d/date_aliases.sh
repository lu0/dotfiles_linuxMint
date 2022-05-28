#!/usr/bin/env bash

alias dateiso="date +%Y-%m-%dT%H:%M:%S%z"
alias datefile="date +%y%m%d-%H%M%S"

# Converts unix timestamp to human-readable date
timestamp() {
    local unix_timestamp="${1}"
    local number_of_digits nano_timestamp
    local seconds milliseconds microseconds nanoseconds

    _show_usage() {
        echo -e "\nMy UNIX-timestamp to Human-readable converter!\n"
        echo -e "Usage: timestamp \$unix_timestamp"
        echo -e "Example: timestamp 1653714714\n"
        echo -e "Formats:"
        echo -e "   10 digits     Seconds to date"
        echo -e "   13 digits     Milliseconds to date"
        echo -e "   16 digits     Microseconds to date"
        echo -e "   19 digits     Nanoseconds to date\n"
    }

    _get_nanoprecision_timestamp() {
        local reversed_timestamp zero_padded
        reversed_timestamp=$(echo "${unix_timestamp}" | rev)
        # Pad up to 19 zeros (long unsigned):
        zero_padded=$(printf "%019lu" "${reversed_timestamp}")
        echo "${zero_padded}" | rev
    }

    number_of_digits=$(echo -n "${unix_timestamp}" | wc -c)
    case "${number_of_digits}" in
        10|13|16|19)
            nano_timestamp=$(_get_nanoprecision_timestamp "${unix_timestamp}")
            seconds=${nano_timestamp:0:9}
            milliseconds=${nano_timestamp:10:3}
            microseconds=${nano_timestamp:13:3}
            nanoseconds=${nano_timestamp:16:3}
            date -d @"${seconds}"
            echo "+ ${milliseconds} milliseconds"
            echo "+ ${microseconds} microseconds"
            echo "+ ${nanoseconds} nanoseconds."
            ;;
        *)
            _show_usage
            ;;
    esac
}
