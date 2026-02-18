import QtQuick
import QtQuick.Controls
import "../config" as C

Slider {
    id: root

    property real radius: 2
    implicitWidth: 150
    implicitHeight: 15
    topPadding: 4
    bottomPadding: 4
    // Prevent cutoff
    leftPadding: handle.height - background.height
    rightPadding: handle.height - background.height

    background: Rectangle {
        x: root.leftPadding
        y: root.topPadding + root.availableHeight / 2 - height / 2
        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        height: 4
        radius: root.radius
        color: C.Config.colors.fg

        Rectangle {
            width: root.visualPosition * parent.width
            height: parent.height
            color: C.Config.colors.blue
            radius: root.radius
        }
    }

    handle: CutRectangle {
        width: root.implicitHeight
        height: root.implicitHeight
        radius: 8
        color: C.Config.colors.blue0
        x: root.visualPosition * (parent.width) - width / 2
    }
}
