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
    visible: _visible || sticky
    property bool superHeldTimerFinished: false
    property bool _visible: keyHandler.pressed && superHeldTimerFinished

    GlobalShortcut {
        id: keyHandler
        name: "bar"

        onPressed: {
            root.superHeldTimerFinished = false;
            superHeldTimer.restart();
        }
    }

    Timer {
        id: superHeldTimer
        interval: 300
        onTriggered: root.superHeldTimerFinished = true
    }

    property bool sticky: Hyprland.monitorFor(screen).id == 1 || (UPower.displayDevice.percentage <= 0.15 && (UPower.displayDevice.state === UPowerDeviceState.Discharging))
    property real standardHeight: sticky ? C.Config.bar.height * 0.5 : 0
    implicitHeight: C.Config.bar.height

    // TODO: Make gradients take C.Config.bar.color
    property Gradient gradientMain: Gradient {
        GradientStop {
            position: 0.0
            color: C.Config.bar.color
        }
        GradientStop {
            position: 0.5
            color: {
                var c = C.Config.bar.color;
                c.a = 0.8;
                return c;
            }
        }
        GradientStop {
            position: 1
            color: "transparent"
        }
    }

    property Gradient gradientSticky: Gradient {
        GradientStop {
            position: 0.0
            color: C.Config.bar.color
        }
        GradientStop {
            position: 0.5
            color: C.Config.bar.color
        }
        GradientStop {
            position: 0.501
            color: "transparent"
        }
    }

    property Gradient gradient: sticky ? gradientSticky : gradientMain
    readonly property bool showBattery: UPower.displayDevice.isLaptopBattery
    anchors.left: true
    anchors.top: true
    anchors.right: true
    color: "transparent"
    exclusiveZone: standardHeight
    // NOTE: What is this?
    WlrLayershell.namespace: "hyprland-shell:bar"
    WlrLayershell.layer: WlrLayer.Top

    // Background
    Rectangle {
        id: barBackground
        visible: true

        gradient: root.gradient
        anchors {
            fill: parent
        }
    }

    Workspaces {
        anchors {
            top: parent.top
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        topMargin: C.Config.bar.centerTopMargin
    }

    RowLayout {
        // Right side
        spacing: 15

        anchors {
            top: parent.top
            right: parent.right
            topMargin: C.Config.bar.sideTopMargin
            rightMargin: C.Config.bar.sideSideMargin
        }

        Weather {

            Behavior on opacity {
                NumberAnimation {
                    duration: C.Config.anim_MEDIUM
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: C.Config.anim_CURVE_SMOOTH_SLIDE
                }
            }
        }

        BarSeparator {
            Behavior on opacity {
                NumberAnimation {
                    duration: C.Config.anim_MEDIUM
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: C.Config.anim_CURVE_SMOOTH_SLIDE
                }
            }
        }

        Battery {
            visible: root.showBattery
        }

        BarSeparator {
            visible: root.showBattery
        }

        Clock {
            fontSize: C.Config.fontSize.small
        }
    }

    Behavior on sticky {
        SmoothedAnimation {
            velocity: 8
        }
    }

    mask: Region {
        width: root.width
        height: root.exclusiveZone
    }
}
