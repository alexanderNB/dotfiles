movealltoworkspacesilent() {
    initial_class="$1"
    workspace="$2"
    shift 2
    hyprctl clients -j | jq -r \
        ".[] | select(.initialClass == \"$initial_class\") | .address" |
        while read -r address; do
            hyprctl dispatch movetoworkspacesilent "$workspace,address:$address"
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
    echo $not
    hyprctl clients -j | jq -r \
        ".[] | select(.initialClass == \"$initial_class\" and (.title | startswith(\"$title\")$not)) | .address" |
        while read -r address; do
            hyprctl dispatch movetoworkspacesilent "$workspace,address:$address"
        done
}

advancedmovealltoworkspacesilent "kitty" 1 "nvim" false
advancedmovealltoworkspacesilent "kitty" 2 "nvim" true
movealltoworkspacesilent "codium" 2
movealltoworkspacesilent "firefox" 3
movealltoworkspacesilent "obsidian" 4
movealltoworkspacesilent "discord" 5
