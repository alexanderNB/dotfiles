
#!/bin/bash

while true; do
    hyprctl dispatch resizeactive $1 $2
    sleep .01
done
