exec=$1
special=$2
to_find=$3

hyprctl dispatch togglespecialworkspace $special
if [ "$(hyprctl clients -j | jq -r '.[].initialTitle' | grep "$to_find")" == "" ]; then
    $exec
fi
