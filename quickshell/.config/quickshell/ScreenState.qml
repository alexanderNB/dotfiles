import QtQuick
import Quickshell
import Quickshell.Hyprland
import "bar" as B
import "notifs" as N
import "osd" as O
import "config" as C
import "overview" as OV

Item {
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

    O.VolumeOSD {}

    // screen: root.screen
    OV.Overview {}
}
