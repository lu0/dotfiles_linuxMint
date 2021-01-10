#!/bin/bash

# GET RESOLUTION AND OFFSET OF THE CURRENT SCREEN -------------------------------------
# Based on Adam's solution: https://superuser.com/a/992924
monitor_index=0
OFFSET_REGEX="\+([-0-9]+)\+([-0-9]+)"
eval "$(xdotool getmouselocation --shell)"                  # returns variables X and Y
while read name width height X_OFFSET Y_OFFSET
# Loop through each screen and compare the offset with the window coordinates
do
    if [ "${X}" -ge "$X_OFFSET" \
        -a "${Y}" -ge "$Y_OFFSET" \
        -a "${X}" -lt "$(($X_OFFSET+$width))" \
        -a "${Y}" -lt "$(($Y_OFFSET+$height))" ]
    then
        MONITOR=$name
        RESOLUTION=${width}x${height}
        break
    fi
    ((monitor_index++))
done < <(xrandr | grep -w connected |
            sed -r "s/^([^ ]*).*\b([-0-9]+)x([-0-9]+)$OFFSET_REGEX.*$/\1 \2 \3 \4 \5/" | 
            sort -nk4,5)

echo "Sending variables to lua..."
echo $MONITOR
echo $RESOLUTION
echo $X_OFFSET
echo $Y_OFFSET
echo $width
echo $height