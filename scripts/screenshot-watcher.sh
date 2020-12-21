#!/bin/bash
# Rename screenshots created by gnome-screenshot
#
# gnome-screenshot doesn't provide an easier way to do this...
# 
# 
# systemctl status screenshot-rename.timer

echo " --- Screenshot Watcher Running --- "

# "Screenshot from " to "ss-"
rename -v 's/Screenshot\ from\ /ss-/' /home/lucero/pictures/screenshots/*.png

# Replace spaces with underscores ("rename" replaces 1st occurrence only)
for file in /home/lucero/pictures/screenshots/* ; do 
    mv "$file" `echo $file | tr ' ' '_'`                        # all occurrences
done

echo " --- Screenshot Watcher Finished --- "