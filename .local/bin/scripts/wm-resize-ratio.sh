#!/bin/bash

side=${1:-+}
percent=${2:-5}

[ "$side" != "+" ] && [ "$side" != "-" ] && exit 1

pid=$(xdotool getwindowfocus)

increase() { echo $(($1 * (100 + percent) / 100)); }
decrease() { echo $(($1 * (100 - percent) / 100)); }

eval "$(xdotool getwindowgeometry --shell "$pid")"

#### RESIZE ####

if [ "$side" = "+" ]; then
    new_width=$(increase "$WIDTH")
    new_height=$(increase "$HEIGHT")
elif [ "$side" = "-" ]; then
    new_width=$(decrease "$WIDTH")
    new_height=$(decrease "$HEIGHT")
fi

#### MOVE ####

if [ "$side" = "+" ]; then
    diff_width=$((new_width - WIDTH))
    diff_height=$((new_height - HEIGHT))
elif [ "$side" = "-" ]; then
    diff_width=$((WIDTH - new_width))
    diff_height=$((HEIGHT - new_height))
fi

eval "$(xwininfo -id "$(xdotool getactivewindow)" |
    sed -n -e "s/^ \+Absolute upper-left X: \+\([0-9]\+\).*/pos_x=\1/p" \
        -e "s/^ \+Absolute upper-left Y: \+\([0-9]\+\).*/pos_y=\1/p")"

if [ "$side" = "+" ]; then
    pos_x="$((pos_x - diff_width))"
    pos_y="$((pos_y - diff_height))"
elif [ "$side" = "-" ]; then
    pos_x="$((pos_x + diff_width))"
    pos_y="$((pos_y + diff_height))"
fi

xdotool windowsize "$pid" "$new_width" "$new_height" windowmove "$pid" "$pos_x" "$pos_y"
