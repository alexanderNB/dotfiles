#!/usr/bin/env bash

# Query Hyprland for the active window in JSON
active_json=$(hyprctl activewindow -j)

# Extract the title and ID (address)
win_title=$(jq -r '.title' <<<"$active_json")
win_id=$(jq -r '.address' <<<"$active_json")
win_class=$(jq -r '.class' <<<"$active_json")




# Send a notification with both pieces of info
notify-send "Active Window" "Title: $win_title\nID: $win_id\nClass: $win_class"

notify-send "$(kitty @ ls)"


if [[ "$win_class" == "kitty" ]]; then
    notify-send "Tries cd'ing to root"
    kitty @ send-text --match id:1 "cd ~"$'\n'
fi
