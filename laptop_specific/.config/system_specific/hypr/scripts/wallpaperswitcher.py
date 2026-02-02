import os
import random
import time

time.sleep(1)

# with os.scandir(".config/hypr/wallpapers/") as d:
with os.scandir(os.path.expanduser("~") + "/.config/hypr/wallpapers/") as d:
    a = list(map(lambda x: x.name, d))

    while True:
        b = a[random.randint(0, len(a)-1)]
        os.system(f"hyprctl hyprpaper wallpaper eDP-1, ~/.config/hypr/wallpapers/{b}, cover")
        time.sleep(600)
