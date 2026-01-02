import "../config" as C
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io

PanelWindow {
    id: root
    // visible: (Hyprland.monitorFor(screen).activeWorkspace.id == Hyprland.monitorFor(screen).activeWorkspace.name) ? true : false
    visible: _visible
    // visible: true
    property bool _visible: false
    property bool compact: false
    property real barRadius: C.Config.settings.panels.radius
    // property real barHeight: C.Config.settings.bar.height
    property real barHeight: 45
    property real gapsHorz: C.Config.settings.bar.horizontalGap
    property real gapsVert: C.Config.settings.bar.verticalGap
    property real innerPadHorz: 8
    // property real compactHeight: barHeight
    property real compactHeight: 0
    // property real standardHeight: barHeight + gapsVert
    property real standardHeight: 0
    readonly property real borderMargin: C.Config.settings.panels.borders ? 1 : 0
    readonly property real topContentMargin: borderMargin + (C.Config.edge == C.Config.BarEdge.Top ? uncompactState : compactState) * gapsVert
    readonly property real bottomContentMargin: borderMargin + (C.Config.edge == C.Config.BarEdge.Bottom ? uncompactState : compactState) * gapsVert
    readonly property bool showBattery: UPower.displayDevice.isLaptopBattery
    property real compactState: compact ? 1 : 0
    property real uncompactState: 1 - compactState

    anchors: C.Config.barAnchors
    color: "transparent"
    exclusiveZone: compact ? compactHeight : standardHeight
    WlrLayershell.namespace: "hyprland-shell:bar"
    WlrLayershell.layer: WlrLayer.Top
    implicitHeight: barHeight * 1.5 + gapsVert

    IpcHandler {
        target: "bar"

        function toggle() {
            root._visible = !root._visible;
        }
        function close() {
            root._visible = false;
        }
        function open() {
            root._visible = true;
        }
    }
    // Background
    Rectangle {
        id: barBackground
        visible: true

        radius: root.uncompactState * root.barRadius
        // color: C.Config.applyBaseOpacity(C.Config.theme.background)
        // color: "#FFFFFF"
        // color: "#1F1F1F"
        border.width: C.Config.settings.panels.borders ? root.uncompactState * root.borderMargin : 0
        // border.width: 0
        // border.bottom.width: 5

        border.color: C.Config.applyBaseOpacity(C.Config.theme.outline_variant)
        // border.color: "#FFFFFF"
        gradient: Gradient {
            GradientStop {
                position: 0.0
                // color: "#1A1B26"
                color: "#1F1F1F"
            }
            GradientStop {
                position: 0.4
                color: "#F01F1F1F"
                // color: "#1F1F1F"
            }
            GradientStop {
                position: 1
                color: "transparent"
                // color: "#00FFFFFF"
                // color: "#1F1F1F"
            }
        }

        anchors {
            fill: parent
            leftMargin: root.uncompactState * root.gapsHorz
            rightMargin: root.uncompactState * root.gapsHorz
            topMargin: root.topContentMargin - root.borderMargin
            bottomMargin: root.bottomContentMargin - root.borderMargin
        }
    }

    // Title in the middle
    WindowTitle {
        id: barWindowTitle
        visible: false

        panelWindow: root
        anchors.centerIn: barBackground

        width: 500
    }
    Workspaces {
        anchors {
            top: parent.top
            bottom: parent.bottom
            // horiz: parent.left
            // centerIn: barBackground
            horizontalCenter: parent.horizontalCenter
        }
        topInset: root.topContentMargin - root.borderMargin
        bottomInset: root.bottomContentMargin - root.borderMargin
        // Layout.leftMargin: 8
        // Layout.rightMargin: 8
    }

    RowLayout {
        // Left side
        visible: false
        spacing: 10

        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }

        LeftMenuButton {
            leftMargin: barBackground.anchors.leftMargin + root.borderMargin
            topMargin: root.topContentMargin
            bottomMargin: root.bottomContentMargin
            topLeftRadius: barBackground.radius - root.borderMargin
            bottomLeftRadius: topLeftRadius
        }

        // BarSeparator {
        //     Layout.topMargin: root.topContentMargin
        //     Layout.bottomMargin: root.bottomContentMargin
        // }

        // Workspaces {
        //     topInset: root.topContentMargin - root.borderMargin
        //     bottomInset: root.bottomContentMargin - root.borderMargin
        //     Layout.leftMargin: 8
        //     Layout.rightMargin: 8
        // }

        BarSeparator {
            visible: barMpris.visible
            Layout.topMargin: root.topContentMargin
            Layout.bottomMargin: root.bottomContentMargin
        }

        Mpris {
            id: barMpris

            topMargin: root.topContentMargin
            bottomMargin: root.bottomContentMargin
            Layout.maximumWidth: 350
        }
    }

    RowLayout {
        // Right side
        spacing: 15

        anchors {
            top: parent.top
            bottom: parent.top
            right: parent.right
        }

        Weather {
            opacity: C.Config.settings.bar.weather ? 1 : 0
            visible: opacity != 0
            Layout.topMargin: root.topContentMargin + 5
            Layout.bottomMargin: root.bottomContentMargin

            Behavior on opacity {
                NumberAnimation {
                    duration: C.Globals.anim_MEDIUM
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: C.Globals.anim_CURVE_SMOOTH_SLIDE
                }
            }
        }

        BarSeparator {
            opacity: C.Config.settings.bar.weather ? 1 : 0
            visible: opacity != 0
            Layout.topMargin: root.topContentMargin
            Layout.bottomMargin: root.bottomContentMargin

            Behavior on opacity {
                NumberAnimation {
                    duration: C.Globals.anim_MEDIUM
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: C.Globals.anim_CURVE_SMOOTH_SLIDE
                }
            }
        }

        Battery {
            visible: root.showBattery
            Layout.topMargin: root.topContentMargin
            Layout.bottomMargin: root.bottomContentMargin
        }

        BarSeparator {
            visible: root.showBattery
            Layout.topMargin: root.topContentMargin
            Layout.bottomMargin: root.bottomContentMargin
        }

        Clock {
            Layout.topMargin: root.topContentMargin
            Layout.bottomMargin: root.bottomContentMargin
        }

        BarSeparator {
            Layout.topMargin: root.topContentMargin
            Layout.bottomMargin: root.bottomContentMargin
        }

        RightMenuButton {
            topMargin: root.topContentMargin
            bottomMargin: root.bottomContentMargin
            rightMargin: barBackground.anchors.rightMargin + root.borderMargin
            topRightRadius: barBackground.radius - root.borderMargin
            bottomRightRadius: topRightRadius
            Layout.leftMargin: -6
        }
    }

    Behavior on compactState {
        SmoothedAnimation {
            velocity: 8
        }
    }

    mask: Region {
        width: root.width
        height: root.exclusiveZone
    }
}
