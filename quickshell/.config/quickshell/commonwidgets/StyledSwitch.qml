import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "../config" as C

Switch {
    id: root

    implicitHeight: 20
    implicitWidth: 35
    property real switchHandlePadding: 3
    property real switchHandlePaddingUnchecked: 5

    background: Rectangle {
        radius: root.height / 2
        color: checked ? C.Config.colors.cyan : C.Config.colors.fg

        border.width: checked ? 1 : 2
        border.color: checked ? C.Config.colors.orange : "black"

        Behavior on color {
            ColorAnimation {
                duration: C.Config.anim_MEDIUM
                easing.type: Easing.BezierSpline
                easing.bezierCurve: C.Config.anim_CURVE_SMOOTH_SLIDE
            }
        }
    }

    indicator: Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        property real padding: checked ? root.switchHandlePadding : root.switchHandlePaddingUnchecked
        property real size: root.height - padding * 2
        x: root.checked ? root.width - (width + padding) : padding
        width: size
        height: size
        radius: root.height / 2
        color: C.Config.colors.blue7

        Behavior on x {
            NumberAnimation {
                duration: C.Config.anim_MEDIUM
                easing.type: Easing.BezierSpline
                easing.bezierCurve: C.Config.anim_CURVE_SMOOTH_SLIDE
            }
        }
    }
}
