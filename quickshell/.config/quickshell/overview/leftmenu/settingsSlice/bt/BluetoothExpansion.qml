import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Bluetooth

import "../../../../config" as C
import "../../../../commonwidgets" as CW
import "../../../../state" as S

WrapperRectangle {
    id: root
    required property BluetoothDevice device
    readonly property bool stateChanging: device.state === BluetoothDeviceState.Connecting || device.state == BluetoothDeviceState.Disconnecting

    color: C.Config.colors.bg_highlight
    property int fontSize: C.Config.fontSize.small
    radius: 6

    ColumnLayout {
        id: cl

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: 6
        }

        CW.StyledText {
            text: root.device.deviceName + (root.device.batteryAvailable ? `, ${root.device.battery * 100}% Battery` : "")
            fontSize: root.fontSize
        }

        RowLayout {
            anchors {
                left: parent.left
                right: parent.right
            }
            Layout.fillWidth: true

            CW.StyledText {
                Layout.alignment: Qt.AlignTop
                Layout.topMargin: 2
                text: root.device.connected ? "Connected" : (root.device.paired ? "Paired" : "Not Connected")
                fontSize: root.fontSize
            }

            Rectangle {
                color: ma.containsMouse ? Qt.lighter(C.Config.colors.bg) : C.Config.colors.bg
                radius: 6
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: text.width + 10
                Layout.preferredHeight: text.height + 5
                Layout.bottomMargin: 12
                Layout.rightMargin: 0

                CW.StyledText {
                    id: text
                    anchors.centerIn: parent
                    fontSize: root.fontSize
                    text: {
                        switch (root.device.state) {
                        case BluetoothDeviceState.Disconnected:
                            return (root.device.paired ? "Connect" : "Pair");
                        case BluetoothDeviceState.Connecting:
                            return "Connecting";
                        case BluetoothDeviceState.Connected:
                            return "Disconnect";
                        case BluetoothDeviceState.Disconnecting:
                            return "Disconnecting";
                        }
                    }
                }

                WrapperMouseArea {
                    id: ma

                    hoverEnabled: true
                    anchors.fill: parent

                    onClicked: {
                        if (root.stateChanging)
                            return;
                        else if (root.device.connected)
                            root.device.disconnect();
                        else if (root.device.paired)
                            root.device.connect();
                        else {
                            root.device.pair();
                            root.device.trusted = true;
                        }
                    }
                }
            }
        }
    }
}
