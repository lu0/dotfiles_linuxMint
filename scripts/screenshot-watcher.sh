#!/usr/bin/env bash

#
# Renames screenshots created by gnome-screenshot,
# since it names them with spaces and mixed cases, and it
# doesn't provide an easy way to do change the naming convention...
#
# This works from year 2020 up until 2099 :P
#
# Will I manage to leave more than 104 years and still use this script ? ...
# Will GNU Hurd take over Linux? Will GNU Hurd's have BASH ?
# Will humanity still exist based on recent events?
# We'll find out (or not).
#

PICTURES_PATH=~/pictures/screenshots

# Renames screenshot from
# 'Screenshot from YYYY-MM-DD HH-mm-ss small description.png'
# to
# 'ss-YYMMDD-HHmmss-small-description.png'
rename_screenshot() {

    local dir="${1}"
    local old_file_name="${2}"

    # YY-MM-DD
    date_regex="([2-9][0-9])-(0[1-9]|1[0-2])-([0-2][0-9]|3[0-1])"
    #        year 20..99 | month 01..09  |      day 01..29
    #                    |  or 10,11,12  |        or 30,31
    #                  dash             dash

    # HH-mm-ss
    hour_regex="([0-1][0-9]|2[0-3])"   # 00..19 or 20..23
    min_regex="([0-5][0-9])"           # 00..59
    sec_regex="${min_regex}"           # 00..59
    time_regex="${hour_regex}-${min_regex}-${sec_regex}"

    # 'YY-MM-DD HH-mm-ss'
    datetime_regex="^${date_regex} ${time_regex}$"

    # 'Screenshot from 2020-12-21 19-19-35 small description.png'
    echo "New file '${old_file_name}' found in '$dir'"

    # '20-12-21 19-19-35'
    file_datetime=${old_file_name:18:17}

    if [[ "${file_datetime}" =~ ${datetime_regex} ]]; then
        # 'ss 20-12-21 19-19-35 small description.png'
        old_prefix="Screenshot from 20"
        new_prefix="ss"
        name_new_prefix=${old_file_name//${old_prefix}/"${new_prefix} "}

        # 'ss 201221 191935 small description.png'
        name_no_dashes=${name_new_prefix//-/}

        # 'ss-201221-191935-small-description.png'
        name_spaces_by_dashes=${name_no_dashes// /-}

        new_file_name="${name_spaces_by_dashes}"

        mv "${dir}/${old_file_name}" "${dir}/${new_file_name}"
        echo "File renamed from ${old_file_name} to ${new_file_name}"
    fi
}

# Watches for the creation of a file change in a given directory,
# returns the directory, action and name of the file.
watch_changes_in_dir() {
    inotifywait -m "${1}" -e create -e moved_to
}


main_loop() {
    watch_changes_in_dir "${PICTURES_PATH}" |
    while read -r dir _ file_name; do
        rename_screenshot "${dir}" "${file_name}"
    done
}

main_loop
