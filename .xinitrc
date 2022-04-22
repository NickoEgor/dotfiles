#!/bin/bash

# autostart
dunst &
picom &
sxhkd &
# unclutter &
# greenclip daemon &
# safeeyes &
# suspender &
# pgrep transmission-da || transmission-daemon &
# redshift &
nm-applet &

sleep 3 && exec polybar -r notebar &

# Xorg settings
xwallpaper --stretch "$XDG_DATA_HOME/wallpaper"
# xmodmap -e "keycode 135 = Super_R Menu"   # remap 'menu' button
xset r rate 200 35                        # keyboard speed
xsetroot -cursor_name left_ptr            # default cursor
# xset s on                                 # enable screensaver
# xset s 600                                # seconds before screensave
xrdb -merge "$XDG_CONFIG_HOME/Xresources" # apply xresources
# xss-lock -- physlock -ms &                # set screen lock

/usr/bin/vmware-user

exec "$WM"
