import QtQuick
import Quickshell
import Quickshell.Hyprland
import "bar" as B
import "keybinds" as K
import "notifs" as N
import "osd" as O
import "config" as C

Scope {
    id: root

    property ShellScreen screen
    property bool hasFullscreenWindow: C.Config.settings.panels.compactEnabled && Hyprland.monitorFor(screen).activeWorkspace.hasFullscreen

    B.Bar {
        screen: root.screen
        compact: root.hasFullscreenWindow
    }

    N.NotificationPanel {
        screen: root.screen
    }

    O.OnScreenDisplay {
        screen: root.screen
    }

}
