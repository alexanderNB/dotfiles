import "../config" as C
import "leftmenu" as LM
import "rightmenu" as RM
import "../popup" as P
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
    visible: Hyprland.focusedWorkspace?.name === "overview"
    // visible: true

    RM.RightMenu {
        visible: root.visible
    }

    LM.LeftMenu {
        visible: root.visible
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
