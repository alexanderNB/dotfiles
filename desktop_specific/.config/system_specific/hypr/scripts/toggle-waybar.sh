#!/bin/bash

cursorpos="$(hyprctl cursorpos)"
cursorpos="${cursorpos%%,*}"

if ((cursorpos < 1920)); then
    if [ "$(pgrep -f "waybar.*--log-level=2")" ]; then
        pkill -f "waybar.*--log-level=2"
    else
        waybar -c ~/.config/waybar/config2.jsonc -s ~/.config/waybar/style2.css --log-level=2 &
    fi
else
    if [ "$(pgrep -f "waybar.*--log-level=1")" ]; then
        pkill -f "waybar.*--log-level=1"
    else
        waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css --log-level=1 &
    fi
fi
