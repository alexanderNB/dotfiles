#!/bin/bash

pc="laptop"

command="$1"
workspace="$2"

cursorpos="$(hyprctl cursorpos)"
cursorpos="${cursorpos%%,*}"
if [[ $pc == "desktop" ]]; then
    if ((cursorpos < 1920)); then
        workspace="$((workspace + 10))"
    fi
fi
hyprctl dispatch "$command" "$workspace"
