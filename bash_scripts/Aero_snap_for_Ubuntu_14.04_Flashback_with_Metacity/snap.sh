#!/bin/bash
# input parameters are variables inside the script numbered from 1 to number of space-separated input parameters
# possible parameters resulting in variable $1 are: left, right, up, down // lowercase only!
# usage: keybind the script like "script.sh right"

# snap left 
if [ $1 = "left" ]; then
sleep 0.1 && wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz && wmctrl -r :ACTIVE: -e 0,0,0,`xwininfo -root | grep Width | awk '{ print (($2/2)-2)}'`,`xwininfo -root | grep Height | awk '{ print $2 }'`

# snap right
elif [ $1 = "right" ]; then
sleep 0.1 && wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz && wmctrl -r :ACTIVE: -e 0,`xwininfo -root | grep Width | awk '{ print (($2/2))}'`,0,`xwininfo -root | grep Width | awk '{ print (($2/2))}'`,`xwininfo -root | grep Height | awk '{ print $2 }'`

# snap up
elif [ $1 = "up" ]; then
sleep 0.1 && wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz && wmctrl -r :ACTIVE: -e 0,0,0,`xwininfo -root | grep Width | awk '{ print $2 }'`,`xwininfo -root | grep Height | awk '{ print (($2/2)-40)}'`

# snap down
elif [ $1 = "down" ]; then
sleep 0.1 && wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz && wmctrl -r :ACTIVE: -e 0,0,`xwininfo -root | grep Height | awk '{ print (($2/2))}'`,`xwininfo -root | grep Width | awk '{ print $2 }'`,`xwininfo -root | grep Height | awk '{ print (($2/2)-40)}'`

#in any other case exit without doing anything
fi
