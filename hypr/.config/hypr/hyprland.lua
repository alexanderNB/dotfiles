
-----------------
--- VARIABLES ---
-----------------

Terminal = "kitty"
FileManager = "dolphin"
Browser = "zen-browser"
require("variables")

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



------------
--- MISC ---
------------
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")


