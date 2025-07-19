hyprctl dispatch togglespecialworkspace discord
if [ "$(pgrep -x "Discord")" == "" ]; then
    discord
fi
