#!/usr/bin/env bash

# app="$1"
# workspace="$2"
# initial_title="$3"

totalapps=0
counter=0
declare -a apps
declare -a workspaces
declare -a initial_titles
while [[ $# -gt 0 ]]; do
    case $(($counter % 3)) in
    0)
        apps[$totalapps]="$1"
        shift
        ;;
    1)
        workspaces[$totalapps]="$1"
        shift
        ;;
    2)

        initial_titles[$totalapps]="$1"
        shift
        ((totalapps++))
        ;;
    esac
    ((counter++))
done

# hyprctl keyword windowrule workspace ${workspaces[0]} silent, class:"${apps[0]}"
# hyprctl dispatch -- exec [workspace ${workspaces[0]} silent] "${apps[0]}"

# hyprctl keyword windowrule workspace 11 silent, class:"${apps[1]}"
# hyprctl dispatch -- exec [workspace 11 silent] "${apps[1]}"

for ((i = 0; i < $totalapps; i++)); do
    hyprctl keyword windowrule workspace ${workspaces[$i]} silent, class:"${apps[$i]}"
    hyprctl dispatch exec [workspace ${workspaces[$i]} silent] "${apps[$i]}"
done

# hyprctl keyword windowrule workspace $workspace silent, class:"$app"
# hyprctl dispatch -- exec [workspace $workspace silent] "$app"
while true; do
    apps_opened=0
    initialTitles="$(hyprctl clients -j | jq -r '.[].initialTitle')"

    for initial_title in "${initial_titles[@]}"; do
        while IFS= read -r initialTitle; do
            if [[ "$initialTitle" == "$initial_title" ]]; then
                ((apps_opened++))
                break
            fi
        done <<<"$initialTitles"
    done
    if ((apps_opened == totalapps)); then
        echo "CLOSING"
        hyprctl reload
        exit 1
    fi
    sleep 1
done
