movealltoworkspacesilent() {
    initial_class="$1"
    workspace="$2"
    shift 2
    hyprctl clients -j | jq -r \
        ".[] | select(.initialClass == \"$initial_class\") | .address" |
        while read -r address; do
            if [[ $(hyprctl clients -j | jq -r ".[] | select(.address == \"$address\") | .monitor") == 1 ]]; then
                hyprctl dispatch movetoworkspacesilent "$((workspace+10)),address:$address"
            else
                hyprctl dispatch movetoworkspacesilent "$workspace,address:$address"
            fi
        done
}

advancedmovealltoworkspacesilent() {
    initial_class="$1"
    workspace="$2"
    title="$3"
    hastitle="$4"
    not="| not"
    if [[ "$hastitle" == "true" ]]; then
        not=""
    fi
    shift 4
    hyprctl clients -j | jq -r \
        ".[] | select(.initialClass == \"$initial_class\" and (.title | startswith(\"$title\")$not)) | .address" |
        while read -r address; do
            if [[ $(hyprctl clients -j | jq -r ".[] | select(.address == \"$address\") | .monitor") == 1 ]]; then
                hyprctl dispatch movetoworkspacesilent "$((workspace+10)),address:$address"
            else
                hyprctl dispatch movetoworkspacesilent "$workspace,address:$address"
            fi
        done
}

advancedmovealltoworkspacesilent "com.mitchellh.ghostty" 1 "nvim" false
advancedmovealltoworkspacesilent "com.mitchellh.ghostty" 2 "nvim" true
movealltoworkspacesilent "codium" 2
movealltoworkspacesilent "firefox" 3
movealltoworkspacesilent "obsidian" 4
movealltoworkspacesilent "discord" name:discord
movealltoworkspacesilent "steam" name:steam
