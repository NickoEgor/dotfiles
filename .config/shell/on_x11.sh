#!/bin/bash

autostart=(
    "dunst"
    "compton"
    "setwall"
    "sxhkd"
    "greenclip daemon"
    "xboard.sh"
)

for program in "${autostart[@]}"; do
    pidof -sx "$(echo "$program" | cut -d' ' -f1)" || $program &
done >/dev/null 2>&1
