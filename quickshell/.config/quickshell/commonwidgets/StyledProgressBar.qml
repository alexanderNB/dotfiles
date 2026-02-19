import QtQuick
import QtQuick.Controls
import "../config" as C

ProgressBar {
    id: root
    implicitHeight: 4
    implicitWidth: 120

    property color colHighlight: C.Config.colors.blue
    property color colTrough: C.Config.colors.bg

    Behavior on value {
        NumberAnimation {
            duration: C.Config.anim_MEDIUM
            easing.type: Easing.BezierSpline
            easing.bezierCurve: C.Config.anim_CURVE_SMOOTH_SLIDE
        }
    }

    background: null
    contentItem: Item {
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
        }

        Rectangle {
            // Background fill
            z: 0
            radius: root.height / 2
            anchors.fill: parent
            width: root.width
            height: root.height
            color: root.colTrough
        }

        Rectangle {
            // Left fill
            z: 1
            radius: root.height / 2
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
            }
            width: root.width * root.visualPosition
            height: root.height
            color: root.colHighlight
        }
    }
}
