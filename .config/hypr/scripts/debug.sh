#!/usr/bin/env bash

function handle {
    echo "$@"
}

# Socket directory has changed in Hyprland v0.40.0
# socat - UNIX-CONNECT:/tmp/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock | while read line; do handle $line; done
socat -U - UNIX-CONNECT:$(echo $XDG_RUNTIME_DIR)/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock | while read line; do handle $line; done
