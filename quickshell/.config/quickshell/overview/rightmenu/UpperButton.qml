import "../../bar" as B
import "../../commonwidgets" as CW
import "../../config" as C
import "../../state" as S
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

WrapperMouseArea {
    id: root

    property string icon: "visibility"
    property string description: "Vax was here"
    property bool active: false

    signal toggled

    onClicked: () => {
        root.toggled();
    }
    implicitHeight: containsMouse ? text.height : icon.height
    implicitWidth: (containsMouse ? text.width : icon.width) + 10
    hoverEnabled: true

    Rectangle {
        anchors.fill: parent

        color: active ? C.Config.colors.blue : (root.containsMouse ? Qt.lighter(C.Config.colors.bg) : C.Config.colors.bg)
        radius: 6

        CW.FontIcon {
            id: icon
            anchors.centerIn: parent
            visible: !root.containsMouse
            text: root.icon
            font.pointSize: C.Config.fontSize.normal
            color: active ? C.Config.colors.bg : C.Config.colors.fg
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        CW.StyledText {
            id: text
            anchors.centerIn: parent
            color: active ? C.Config.colors.bg_dark : C.Config.colors.fg
            text: description
            visible: root.containsMouse

            Behavior on visible {
                NumberAnimation {
                    duration: text.visible ? 0 : C.Config.anim_MEDIUM
                    easing.type: Easing.BezierSpline
                }
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: C.Config.anim_MEDIUM
                easing.type: Easing.BezierSpline
            }
        }
    }

    Behavior on implicitWidth {
        SmoothedAnimation {
            duration: root.containsMouse ? C.Config.anim_FAST : C.Config.anim_MEDIUM
            easing.type: Easing.BezierSpline
        }
    }
}
