#!/bin/bash

command="$1"
workspace="$2"

hyprctl dispatch "$command" "$workspace"
