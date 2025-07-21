#!/bin/bash

command="$1"
workspace="$2"

cursorpos="$(hyprctl cursorpos)"
cursorpos="${cursorpos%%,*}"
if ((cursorpos > 2560)); then
    workspace="$((workspace + 10))"
fi
hyprctl dispatch "$command" "$workspace"
