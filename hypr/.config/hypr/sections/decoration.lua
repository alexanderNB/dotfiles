hl.config({
    general = {
        border_size = 0,
        gaps_in = 0,
        gaps_out = 0,
        gaps_workspaces = 50,

        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
    },


    decoration = {
        rounding = 0,
        rounding_power = 2,

        active_opacity = 1,
        inactive_opacity = 1,
        dim_inactive = false,
        dim_strength = 0.05,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 100,
            passes    = 2,
            noise     = 0,
            brightness = 25,
            vibrancy  = 1,
        },

    },


    animations = {
        enabled = true
    }


})


local flash_window_rule = hl.window_rule({
    match = { focus = true },
    opacity = 0.9,
})
flash_window_rule:set_enabled(false)


local flash_timer = hl.timer(
    function ()
        flash_window_rule:set_enabled(false)
    end, { timeout=250, type="repeat" })
flash_timer:set_enabled(false)


--- @param window HL.Window
hl.on("window.active", function (window)
    if #hl.get_workspace_windows(window.workspace) > 1 then
        flash_window_rule:set_enabled(true)
        flash_timer:set_enabled(true)
    end
end)

--- @param monitor HL.Monitor
hl.on("monitor.focused", function (monitor)
    if #hl.get_workspace_windows(monitor.active_workspace) == 1 then
        flash_window_rule:set_enabled(true)
        flash_timer:set_enabled(true)
    end
end)

hl.window_rule({ match = { tag="closing" }, no_blur = true })

--- @param window HL.Window
hl.on("window.close", function (window)
    hl.dispatch(hl.dsp.window.tag({ tag="closing", window=window }))
end)

-- TODO: This doesn't work:
hl.env("HYPRCURSOR_THEME", "hicolor")
hl.env("HYPRCURSOR_SIZE", "48")

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })
hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = false, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = false,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

