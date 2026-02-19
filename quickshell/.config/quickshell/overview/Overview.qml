import "../config" as C
import "leftmenu" as LM
import "rightmenu" as RM
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io

// import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets

Item {
    id: root
    property bool active: (Hyprland.focusedWorkspace?.name === "overview") ?? false

    RM.RightMenu {
        active: root.active
    }

    LM.LeftMenu {
        active: root.active
    }

    // P.LayerPopupDelegate {
    //     hoverable: true
    //     grab: true
    //     anchors.right: true
    //     bar: root.QsWindow.window
    //     clip: true
    //
    //     M.RightMenu {}
    // }
    // Rectangle {
    //     id: testbox
    //     visible: true
    //     radius: 50
    // }
}
