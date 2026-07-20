
-----------------
--- VARIABLES ---
-----------------

Terminal = "kitty"
FileManager = "dolphin"
Browser = "zen-browser"
hl.notification.create({text=#hl.get_monitors(), duration=5000})

if #hl.get_monitors() == 0 or #hl.get_monitors() == 2 then
    System = "PC"
else
    System = "Laptop"
end
hl.notification.create({text=System, duration=5000})



----------------
--- SECTIONS ---
----------------

require("sections.general")
require("sections.input")
require("sections.keybinds")
require("sections.decoration")
require("sections.windowrules")
require("sections.autostart")
require("sections.monitor")

Debug = function (text)
    hl.notification.create({ text=text, duration=500, font_size=40 })
end

RemoteShutdown = function ()
    local i = 10
    local notification_timer = hl.timer(function ()
        if i == 0 then
            hl.exec_cmd("poweroff")
        else
            hl.notification.create({ text="Shutting down in ".. i .. " seconds", duration=900, font_size=40 })
        end
        i = i - 1
    end, { timeout=1000, type="repeat" })
    hl.bind("SUPER_L", function ()
        notification_timer:set_enabled(false)
    end)
end




------------
--- MISC ---
------------
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")


-- local snake_dir = os.getenv("HOME") .. "/hyprsnake"
--
-- package.path = table.concat({
--   package.path,
--   snake_dir .. "/?.lua",
-- }, ";")
--
-- Hyprsnake = require("hyprsnake")
--
-- -- Default options
-- Hyprsnake.set_opts({
--     tick_speed = 200, -- less means faster
--     maps = { -- sintax for keys is the same as hyprland keybinds
--         turn_r = 'right',
--         turn_l = 'left',
--         exit = 'Escape'
--     },
--     grid_size = {32, 18}, -- explanation below
--     snake_color = "ffffff", -- RGB
-- })
--
-- -- Set a bind to launch the game
-- hl.bind("SUPER + SHIFT + G", function() Hyprsnake.launch() end)
--
