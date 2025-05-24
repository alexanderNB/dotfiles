#!/usr/bin/env bash


window_id=""

nn () {
    echo "$window_id"
    notify-send "$window_id"
}

function handle {
    if [[ ${1:0:12} == "activewindow" ]]; then
        window_id=$(echo $1 | cut --delimiter ">" --fields=3 | cut --delimiter "," --fields=1)
    fi
}



# Socket directory has changed in Hyprland v0.40.0
# socat - UNIX-CONNECT:/tmp/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock | while read line; do handle $line; done
socat -U - UNIX-CONNECT:$(echo $XDG_RUNTIME_DIR)/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock | while read line; do handle $line; done
