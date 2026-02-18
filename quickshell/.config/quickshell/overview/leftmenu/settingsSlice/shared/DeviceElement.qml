import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

import "../../../../config" as C
import "../../../../commonwidgets" as CW

Rectangle {
    id: root

    property bool active: false
    property bool hovered: false
    property string label: "Device"
    property string additionalIcon: ""

    color: active ? (hovered ? Qt.lighter(C.Config.colors.blue0) : C.Config.colors.blue0) : (hovered ? Qt.lighter(C.Config.colors.bg_highlight) : C.Config.colors.bg_highlight)
    radius: 6

    implicitHeight: 30

    CW.StyledText {
        anchors.fill: parent
        anchors.leftMargin: 4
        text: label
        verticalAlignment: Text.AlignVCenter
        color: C.Config.colors.fg
    }

    CW.FontIcon {
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 10
        }
        text: additionalIcon
        visible: additionalIcon != ""
    }

    Behavior on color {
        ColorAnimation {
            duration: C.Config.anim_SLOW
            easing.type: Easing.BezierSpline
            easing.bezierCurve: C.Config.anim_CURVE_SMOOTH_SLIDE
        }
    }
}
