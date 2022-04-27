#!/bin/bash

# settings
xset r rate 200 35                        # keyboard speed
xsetroot -cursor_name left_ptr            # default cursor
xset s on                                 # enable screensaver
xset s 600                                # seconds before screensave

# Xresources
if [ -f "$XDG_CONFIG_HOME/Xresources" ]; then
    xrdb -merge "$XDG_CONFIG_HOME/Xresources"
fi

# autostart
if [ -f "$XDG_CONFIG_HOME/autostart/on_x11.sh" ]; then
    "$XDG_CONFIG_HOME/autostart/on_x11.sh" &
fi

[ -n "$WM" ] && exec "$WM"
