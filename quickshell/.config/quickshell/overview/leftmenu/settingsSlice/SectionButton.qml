import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

import "../../../config" as C
import "../../../commonwidgets" as CW

Rectangle {
    id: root

    property string icon: "photo"
    property bool active: false
    property bool hovered: false

    color: active ? (hovered ? Qt.lighter(C.Config.colors.orange) : C.Config.colors.orange) : (hovered ? Qt.lighter(C.Config.colors.bg_highlight) : C.Config.colors.bg_highlight)
    radius: 10

    implicitWidth: 40
    implicitHeight: 40

    CW.FontIcon {
        anchors.centerIn: parent
        text: icon
        color: root.color
    }

    Behavior on color {
        ColorAnimation {
            duration: C.Config.anim_MEDIUM
            easing.type: Easing.BezierSpline
            easing.bezierCurve: C.Config.anim_CURVE_SMOOTH_SLIDE
        }
    }
}
