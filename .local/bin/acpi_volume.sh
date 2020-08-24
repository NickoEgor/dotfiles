#!/bin/sh

# acpi_listen | while read -r line ; do
#     case "$line" in
#         button/mute*)       pulsemixer --toggle-mute ;;
#         button/volumeup*)   pulsemixer --change-volume +5 ;;
#         button/volumedown*) pulsemixer --change-volume -5 ;;
#     esac
# done

acpi_listen | while read -r line ; do
    case "$line" in
        button/mute*)       amixer set Master toggle ;;
        button/volumeup*)   amixer set Master 5+ ;;
        button/volumedown*) amixer set Master 5- ;;
    esac
done
