exec=$1
name=$2
to_find=$3


CURRENTWORKSPACE="$(hyprctl activeworkspace -j | jq -r '.name')"

# if [[ $CURRENTWORKSPACE == $name ]]; then
#     hyprctl dispatch workspace $LASTWORKSPACE
# else
    # export LASTWORKSPACE="$(CURRENTWORKSPACE)"

hyprctl dispatch focusworkspaceoncurrentmonitor name:$name
if [ "$exec" == "messenger" ]; then
    if [ "$(hyprctl clients -j | jq -r '.[].initialClass' | grep "$to_find")" == "" ]; then
        sh -c 'XAPP_FORCE_GTKWINDOW_ICON="/home/archnb/.local/share/ice/icons/Messenger.png" firefox --class WebApp-Messenger4463 --name WebApp-Messenger4463 --profile /home/archnb/.local/share/ice/firefox/Messenger4463 --no-remote "https://www.messenger.com"'
    fi
else
    if [ "$(hyprctl clients -j | jq -r '.[].initialTitle' | grep "$to_find")" == "" ]; then
        $exec
    fi
fi
# fi

