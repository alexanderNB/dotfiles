import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

import "../../../config" as C
import "../../../commonwidgets" as CW

WrapperMouseArea {
    id: root

    property string text: ""

    hoverEnabled: true
    implicitHeight: icon.implicitHeight
    implicitWidth: icon.implicitHeight // Square

    Rectangle {
        id: bg
        anchors.fill: parent

        // color: root.containsMouse ? C.Config.applySecondaryOpacity(Qt.lighter(C.Config.theme.surface_container, 1.8)) : Qt.alpha(C.Config.theme.surface_container, 0)
        color: root.containsMouse ? Qt.darker(C.Config.colors.blue, 1.4) : C.Config.colors.blue
        radius: 8

        CW.FontIcon {
            id: icon
            text: root.text
            font.pointSize: C.Config.fontSize.smallSymbol
            anchors.centerIn: parent
            color: C.Config.colors.bg
        }

        Behavior on color {
            ColorAnimation {
                duration: C.Config.anim_MEDIUM
                easing.type: Easing.BezierSpline
                easing.bezierCurve: C.Config.anim_CURVE_SMOOTH_SLIDE
            }
        }
    }
}
