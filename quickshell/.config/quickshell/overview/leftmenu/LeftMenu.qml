import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell

Item {
    id: root
    PanelWindow {
        visible: root.visible
        // color: "#1F1F1F"
        color: "#000000"
        anchors.left: true
        anchors.top: true
        anchors.bottom: true
        implicitWidth: 457
        implicitHeight: 600
        Item {

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: 10
            }

            ColumnLayout {
                id: leftMenuLayout
                spacing: 15
                anchors {
                    fill: parent
                }
                SettingsSlice {
                    Layout.fillWidth: true
                }
                Mpris {
                    Layout.fillWidth: true
                }
                // SystemTray {
                //     Layout.fillWidth: true
                // }
            }
        }
    }
}
