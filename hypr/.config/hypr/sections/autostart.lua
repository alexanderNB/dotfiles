hl.on("hyprland.start", function () 
    hl.timer(function ()
        hl.dispatch(hl.dsp.focus({ workspace = 1, on_current_monitor=false }))
    end, { timeout=500, type="oneshot" })
    hl.exec_cmd(Terminal,   { workspace = "1 silent" })
    hl.exec_cmd("obsidian", { workspace = "2 silent" })
    hl.exec_cmd(Browser,    { workspace = "3 silent" })
    hl.exec_cmd(Terminal,   { workspace = "4 silent" })
    hl.exec_cmd("discord",  { workspace = "name:discord silent" })
    hl.exec_cmd("steam",    { workspace = "name:steam silent" })
    hl.exec_cmd("zen-browser -P Messenger --new-window www.messenger.com", { workspace = "name:messenger silent" })
    hl.exec_cmd("kitty -o background=black --execute btop", { workspace = "name:overview silent"})

    hl.exec_cmd("hyprlock")
    hl.exec_cmd("QS_NO_RELOAD_POPUP=1 QML_DISABLE_DISK_CACHE=1 quickshell")

    hl.exec_cmd("hyprpaper")
    -- hl.exec_cmd("python ~/.config/hypr/scripts/wallpaperswitcher.py")
    hl.timer(function ()
        local wallpaper_dir = os.getenv("HOME") .. "/.config/hypr/wallpapers/"

        local wallpapers = {}

        local handle = io.popen('ls "' .. wallpaper_dir .. '"')
        if handle then
            for file in handle:lines() do
                table.insert(wallpapers, file)
            end
            handle:close()
        end

        local switch_wallpaper
        if System == "PC" then
            switch_wallpaper = function ()
                local random_wallpaper1 = wallpapers[math.random(1, #wallpapers)]
                local random_wallpaper2 = wallpapers[math.random(1, #wallpapers)]
                hl.exec_cmd("hyprctl hyprpaper wallpaper DP-1, ~/.config/hypr/wallpapers/" .. random_wallpaper1 .. ", cover")
                hl.exec_cmd("hyprctl hyprpaper wallpaper DP-2, ~/.config/hypr/wallpapers/" .. random_wallpaper2 .. ", cover")
            end
        else
            switch_wallpaper = function ()
                local random_wallpaper = wallpapers[math.random(1, #wallpapers)]
                hl.exec_cmd("hyprctl hyprpaper wallpaper eDP-1, ~/.config/hypr/wallpapers/" .. random_wallpaper .. ", cover")
            end
        end

        switch_wallpaper()
        hl.timer(function ()
            switch_wallpaper()
        end, { timeout=600000, type="repeat" })
    end, { timeout=1000, type="oneshot" })



    hl.exec_cmd("kdeconnect-cli --refresh")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    -- hl.exec_cmd("GSK_RENDERER=walker --gapplication-service")
    -- hl.exec_cmd("elephant")
end)
