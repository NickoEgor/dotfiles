#!/bin/bash

# autostart
dunst &
picom &
sxhkd &
unclutter &
clipmenud &
safeeyes &

# WM autostart
if [ "$WM" = "dwm" ]; then
    dwmbar &
    dwmlistener.sh &
fi

# Xorg settings
xwallpaper \
   --output HDMI2 --stretch "$XDG_DATA_HOME/wallpaper" \
   --output DP1 --stretch "$XDG_DATA_HOME/vertical"
xmodmap -e "keycode 135 = Super_R Menu"   # remap 'menu' button
xset r rate 200 35                        # keyboard speed
xsetroot -cursor_name left_ptr            # default cursor
xset s on                                 # enable screensaver
xset s 600                                # seconds before screensave
xss-lock -- physlock -ms &                # set screen lock
xrdb -merge "$XDG_CONFIG_HOME/Xresources" # apply xresources

exec "$WM"
