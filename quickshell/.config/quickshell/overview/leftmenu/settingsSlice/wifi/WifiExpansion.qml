import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

import "../../../../config" as C
import "../../../../commonwidgets" as CW
import "../../../../state" as S

Rectangle {
    id: root

    property string line1: ""
    property string line2: ""
    property string line3: ""
    property string ssid: ""
    property bool active: false

    // color: active ? C.Config.colors.bg : C.Config.colors.red
    color: C.Config.colors.bg_highlight
    property int fontSize: C.Config.fontSize.small
    radius: 6

    implicitHeight: cl.implicitHeight

    ColumnLayout {
        id: cl

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: 6
        }

        // CW.StyledText {
        //     text: line1
        // }
        CW.StyledText {
            text: line2
            fontSize: root.fontSize
        }

        RowLayout {
            Layout.preferredWidth: parent.width
            CW.StyledText {
                Layout.alignment: Qt.AlignTop
                Layout.topMargin: 2
                fontSize: root.fontSize
                text: line3
            }

            Rectangle {
                color: ma.containsMouse ? Qt.lighter(C.Config.colors.bg) : C.Config.colors.bg
                radius: 6
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: connectText.width + 10
                Layout.preferredHeight: connectText.height + 5
                Layout.bottomMargin: 12
                Layout.rightMargin: 0

                CW.StyledText {
                    id: connectText
                    anchors.centerIn: parent
                    text: root.active ? "Disconnect" : "Connect"
                    fontSize: root.fontSize
                }

                WrapperMouseArea {
                    id: ma

                    hoverEnabled: true
                    anchors.fill: parent

                    onClicked: {
                        if (active)
                            S.WifiState.disconnect(root.ssid);
                        else
                            S.WifiState.connect(root.ssid);
                    }
                }
            }
        }
    }
}
