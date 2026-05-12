local smartWorkspace = function(workspace, takewith)
    if hl.get_active_monitor().name == "DP-2" then
        workspace = workspace+10
    end
    if takewith then
        hl.dispatch(hl.dsp.window.move({ workspace = workspace, on_current_monitor=true}))
    else
        hl.dispatch(hl.dsp.focus({ workspace = workspace, on_current_monitor=true }))
    end
end

local resize = function (bind, x, y)
    local resize_timer = hl.timer(function ()
        hl.dispatch(hl.dsp.window.resize({ x = x, y = y, relative = true }))
    end, { timeout = 10, type = "repeat" })
    resize_timer:set_enabled(false)
    hl.bind(bind, function ()
        resize_timer:set_enabled(true)
    end)

    hl.bind(bind, function ()
        resize_timer:set_enabled(false)
    end, { release = true, transparent = true })
end

local workspaceMap = {
    A = 1,
    I = 2,
    S = 3,
    T = 4,
    Y = 5,
    F = 6,
    P = 7,
    period = 8,
    C = 9,
    V = 10
}


--------------------------
--- NAVIGATION (SUPER) ---
--------------------------

for key, value in pairs(workspaceMap) do
    hl.bind("SUPER + " .. key, function ()
        smartWorkspace(value, false)
    end)
end


-- hl.bind("SUPER + TAB", )
hl.bind("SUPER + Q", hl.dsp.focus({ monitor=-1 }))
-- Y
-- F
-- P
-- hl.bind("SUPER + G", )

hl.bind("SUPER + escape", hl.dsp.focus({ workspace=-1 }))
-- A
-- I
-- S
-- T
hl.bind("SUPER + D", function ()
    hl.dispatch(hl.dsp.focus({workspace = hl.get_active_workspace().id+1}))
end)


-- hl.bind("SUPER + ???", )
hl.bind("SUPER + Z", hl.dsp.layout("togglesplit"))
-- period
-- C
-- V
-- hl.bind("SUPER + B", )



-- hl.bind("SUPER + J", )
resize("SUPER + L", -25, 0)
resize("SUPER + U", 0, 25)
resize("SUPER + W", 0, -25)
resize("SUPER + apostrophe", 25, 0)

-- TODO: fullscreen
-- hl.bind("SUPER + aring", hl.dsp.fullscreen)

-- bind = $mainMod, H, resizeactive, -10000 0
hl.bind("SUPER + N", hl.dsp.focus({ direction = "left"}))
hl.bind("SUPER + E", hl.dsp.focus({ direction = "down"}))
hl.bind("SUPER + R", hl.dsp.focus({ direction = "up"}))
hl.bind("SUPER + O", hl.dsp.focus({ direction = "right"}))
-- bind = $mainMod, return, resizeactive, 10000 0
--
-- bind = $mainMod, K, resizeactive, 0 10000
resize("SUPER + M", -10, 0)
resize("SUPER + comma", 0, 10)
resize("SUPER + X", 0, -10)
resize("SUPER + ae", 10, 0)
-- TODO:
-- bind = $mainMod, oslash, exec, sh ~/.config/hypr/scripts/reorder.sh

-------------------------------
--- TAKEWITH (SUPER + CTRL) ---
-------------------------------

for key, value in pairs(workspaceMap) do
    hl.bind("SUPER + CTRL + " .. key, function ()
        smartWorkspace(value, true)
    end)
end

-- hl.bind("SUPER + CTRL + TAB", )
hl.bind("SUPER + CTRL + Q", hl.dsp.window.move({ monitor=-1, follow=true }))
-- Y
-- F
-- P
-- hl.bind("SUPER + CTRL + G", )

hl.bind("SUPER + CTRL + escape", hl.dsp.window.move({ workspace=-1 }))
-- A
-- I
-- S
-- T
hl.bind("SUPER + CTRL + D", function ()
    hl.dispatch(hl.dsp.window.move({workspace = "+1"}))
end)

-- hl.bind("SUPER + CTRL + ???", )
-- hl.bind("SUPER + CTRL + Z", hl.dsp.layout("togglesplit"))
-- period
-- C
-- V
-- hl.bind("SUPER + CTRL + B", )



-- hl.bind("SUPER + CTRL + J", )
-- hl.bind("SUPER + CTRL + L", )
-- hl.bind("SUPER + CTRL + U", )
-- hl.bind("SUPER + CTRL + W", )
-- hl.bind("SUPER + CTRL + apostrophe", )
-- hl.bind("SUPER + CTRL + aring", )


-- hl.bind("SUPER + CTRL + H", )
hl.bind("SUPER + LEFT", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + DOWN", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + UP", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + RIGHT", hl.dsp.window.move({ direction = "right" }))
-- hl.bing("SUPER + CTRL + ENTER", )

-- hl.bing("SUPER + CTRL + K", )
-- hl.bing("SUPER + CTRL + M", )
-- hl.bing("SUPER + CTRL + COMMA", )
-- hl.bing("SUPER + CTRL + X", )
-- hl.bing("SUPER + CTRL + Æ", )
-- hl.bing("SUPER + CTRL + Ø", )

----------------------------
--- EXEC (SUPER + SHIFT) ---
----------------------------

-- TODO: Screenshot
-- hl.bind("SUPER + SHIFT + TAB", )

-- hl.bind("SUPER + SHIFT + Q", )
-- hl.bind("SUPER + SHIFT + Y", )
hl.bind("SUPER + SHIFT + F", hl.dsp.exec_cmd(FileManager))
-- hl.bind("SUPER + SHIFT + P", )
-- hl.bind("SUPER + SHIFT + G", )

-- hl.bind("SUPER + SHIFT + espace", )

-- TODO: Overview
-- hl.bind("SUPER + SHIFT + A", )

hl.bind("SUPER + SHIFT + I", hl.dsp.exec_cmd("obsidian"))
hl.bind("SUPER + SHIFT + S", function ()
    hl.dispatch(hl.dsp.focus({workspace = "name:steam"}))
    hl.dispatch(hl.dsp.exec_cmd("steam"))
end)
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd(Terminal))
hl.bind("SUPER + SHIFT + D", function ()
    hl.dispatch(hl.dsp.focus({workspace = "name:discord"}))
    hl.dispatch(hl.dsp.exec_cmd("discord"))
end)

-- hl.bind("SUPER + SHIFT + ???", )
-- hl.bind("SUPER + SHIFT + Z", )
-- hl.bind("SUPER + SHIFT + period", )
hl.bind("SUPER + SHIFT + C", hl.dsp.window.close())

-- TODO: Code
-- hl.bind("SUPER + SHIFT + V", )

hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd(Browser))



-- hl.bind("SUPER + SHIFT + J", )
-- hl.bind("SUPER + SHIFT + L", )
-- hl.bind("SUPER + SHIFT + U", )
-- hl.bind("SUPER + SHIFT + W", )
-- hl.bind("SUPER + SHIFT + qoute", )
-- hl.bind("SUPER + SHIFT + Å", )

-- hl.bind("SUPER + SHIFT + H", )
hl.bind("SUPER + SHIFT + N", hl.dsp.layout("preselect left"))
hl.bind("SUPER + SHIFT + E", hl.dsp.layout("preselect down"))
hl.bind("SUPER + SHIFT + R", hl.dsp.layout("preselect up"))
hl.bind("SUPER + SHIFT + O", hl.dsp.layout("preselect right"))
-- hl.bind("SUPER + SHIFT + enter", )

-- hl.bind("SUPER + SHIFT + K", )
hl.bind("SUPER + SHIFT + M", function ()
    hl.dispatch(hl.dsp.focus({ workspace = "name:messenger" }))
    -- hl.exec_cmd("zen-browser -P Messenger --new-window www.messenger.com", { workspace = "name:messenger" })
end)
-- hl.bind("SUPER + SHIFT + semicolon", )
-- hl.bind("SUPER + SHIFT + X", )
-- hl.bind("SUPER + SHIFT + Æ", )
-- hl.bind("SUPER + SHIFT + Ø", )

--- EXTRA
hl.bind("SUPER_L", hl.dsp.global("quickshell:bar"), { transparent=true })
hl.bind("SUPER + SUPER_L", hl.dsp.global("quickshell:bar"), { release=true, transparent=true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("amixer -q sset Master 2%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("amixer -q sset Master 2%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("amixer -q sset Master toggle"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 1%+"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 1%-"), { repeating = true, locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

for i = 0, 9, 1 do
    hl.bind("SUPER + " .. i, function ()
        smartWorkspace(i+1, false)
    end)
    hl.bind("SUPER + SHIFT + " .. i, function ()
        smartWorkspace(i+1, true)
    end)
end
