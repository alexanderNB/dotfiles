exec=$1
name=$2
to_find=$3


CURRENTWORKSPACE="$(hyprctl activeworkspace -j | jq -r '.name')"

if [[ $CURRENTWORKSPACE == $name ]]; then
    hyprctl dispatch workspace $LASTWORKSPACE
else
    export LASTWORKSPACE="$(CURRENTWORKSPACE)"

    hyprctl dispatch focusworkspaceoncurrentmonitor $name
    if [ "$(hyprctl clients -j | jq -r '.[].initialTitle' | grep "$to_find")" == "" ]; then
        $exec
    fi
fi

