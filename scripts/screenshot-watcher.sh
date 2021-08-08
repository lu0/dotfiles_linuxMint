#!/bin/bash
# Rename screenshots created by gnome-screenshot
#
# gnome-screenshot doesn't provide an easier way to do this...
# sudo apt install inotify-tools
# 
# 
# systemctl status screenshot-rename.timer

# echo " --- Screenshot Watcher Running --- "

dir_name='${HOME}/pictures/screenshots/'

inotifywait -m ${dir_name} -e create -e moved_to |
    while read dir action file; do
        echo "New file {'$file'} in directory '$dir'"

        # 'Screenshot from 2020-12-21 19-19-35 one two.png'    # ORIGINAL
        rename -v 's/Screenshot\ from\ 20/ss /' $dir*.png     # 'ss 20-12-21 19-19-35 one two.png'

        base_name="${file##*/}"      # Remove everything before last slash (/)
        pattern=${base_name:3:17}    # '20-12-21 19-19-35'

        date_regexp='(2[0-9])-(0[1-9]|1[0-2])-([0-2][0-9]|3[0-1])'
        #        year 20..29 | month 01..09  |      day 01..29
        #                    |  or 10,11,12  |        or 30,31
        #                  dash             dash
        #
        hour_regexp='([0-1][0-9]|2[0-3])'   # 00..19 or 20..23
        min_regexp='([0-5][0-9])'           # 00..59
        sec_regexp='([0-5][0-9])'           # 00..59

        if [[ $pattern =~ ^$date_regexp[\ ]$hour_regexp-$min_regexp-$sec_regexp$ ]]; then
            # delete all dashes, then replace every space with a dash
            new_name=`echo $file | sed 's/-//g' | sed 's/ /-/g'`

            mv "${dir}$file" "${dir}$new_name"       # 'ss-201221-191935-one-two.png' # NEW NAME
	        echo "Renamed from ${file} to ${new_name}"
        fi
        
    done
