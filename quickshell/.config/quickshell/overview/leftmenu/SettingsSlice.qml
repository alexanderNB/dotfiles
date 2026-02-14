import "../../config" as C
import "settingsSlice" as SL
import "../../commonwidgets" as CW
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

WrapperItem {
    id: root

    ColumnLayout {
        spacing: 10
        anchors.fill: parent

        SL.WifiSection {
            id: wifiSection

            visible: true
            z: 2

            anchors {
                left: parent.left
                right: parent.right
            }
        }
        CW.HorizontalLine {}

        SL.BluetoothSection {
            id: bluetoothSection

            z: 2

            anchors {
                left: parent.left
                right: parent.right
            }

            Behavior on opacity {
                NumberAnimation {
                    duration: C.Globals.anim_MEDIUM
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: C.Globals.anim_CURVE_SMOOTH_SLIDE
                }
            }
        }

        SL.BrightnessSection {
            id: brightnessSection
            z: 2

            anchors {
                left: parent.left
                right: parent.right
            }
        }

        SL.AudioSection {
            id: audioSection

            z: 2

            anchors {
                left: parent.left
                right: parent.right
            }
        }
    }

    component SectionButton: WrapperMouseArea {
        id: button

        required property var section
        property alias icon: sb.icon

        hoverEnabled: true
        onPressed: {
            if (root.activeSection == section)
                root.activeSection = null;
            else
                root.activeSection = section;
        }

        SL.SectionButton {
            id: sb

            hovered: button.containsMouse
            active: root.activeSection == button.section
        }
    }
}
