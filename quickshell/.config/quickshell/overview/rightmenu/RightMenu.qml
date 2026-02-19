import "../../commonwidgets" as CW
import "../../config" as C
import "../../notifs" as N
import "../../state" as S
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

Item {
    id: root
    property bool idleInhibitEnabled: false

    implicitWidth: 360 // notifs are 360

    PanelWindow {
        id: panelWindow
        visible: root.visible
        anchors.right: true
        anchors.top: true
        anchors.bottom: true
        implicitWidth: 500
        color: "black"

        Item {
            anchors {
                fill: parent
                margins: 10
            }

            ColumnLayout {
                id: rightMenuLayout

                // opacity: 1
                visible: true
                spacing: 15
                anchors.fill: parent
                z: 2

                Clock {
                    Layout.fillWidth: true
                    implicitHeight: 120
                }

                CW.HorizontalLine {}

                RowLayout {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 30

                    Item {
                        Layout.fillWidth: true
                    }

                    UpperButton {
                        icon: "visibility"
                        description: "Idle Inhibit"
                        active: idleInhibitEnabled
                        onToggled: () => {
                            idleInhibitEnabled = !idleInhibitEnabled;
                            S.SystemState.setHypridleStatus(!idleInhibitEnabled);
                        }
                    }

                    UpperButton {
                        icon: "do_not_disturb_on"
                        description: "Do Not Disturb"
                        active: S.NotificationState.dndEnabled
                        onToggled: () => {
                            S.NotificationState.dndEnabled = !S.NotificationState.dndEnabled;
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                    }
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.rightMargin: -15

                    // Notifications
                    ListView {
                        id: notifScroll
                        anchors.fill: parent
                        clip: true

                        // model: ScriptModel {
                        //     values: S.NotificationState.trackedNotifs
                        // }

                        model: S.NotificationState.trackedNotifs

                        delegate: N.NotificationBox {
                            required property N.TrackedNotification modelData
                            trackedNotif: modelData
                            hasDismiss: false
                            entryFactor: trackedNotif.entryFactor
                        }
                    }

                    WrapperMouseArea {
                        id: clearNotifMa

                        anchors {
                            right: parent.right
                            bottom: parent.bottom
                            rightMargin: 15
                        }

                        opacity: S.NotificationState.trackedNotifs.length === 0 ? 0 : 1
                        visible: opacity != 0

                        implicitHeight: clearSymbol.width
                        implicitWidth: clearSymbol.width
                        // implicitHeight: 35
                        // implicitWidth: 40
                        hoverEnabled: true
                        onPressed: () => {
                            S.NotificationState.trackedNotifs = [];
                        }

                        Rectangle {
                            anchors.fill: parent
                            radius: 4
                            // visible: clearNotifMa.containsMouse
                            color: clearNotifMa.containsMouse ? C.Config.colors.bg_highlight : panelWindow.color

                            CW.FontIcon {
                                id: clearSymbol
                                visible: true
                                anchors.centerIn: parent
                                text: "delete"
                                color: C.Config.colors.red1
                                iconSize: C.Config.fontSize.hugeSymbol
                            }

                            Behavior on color {
                                ColorAnimation {
                                    duration: 400
                                    easing.type: Easing.BezierSpline
                                    easing.bezierCurve: C.Config.anim_CURVE_SMOOTH_SLIDE
                                }
                            }
                        }
                    }

                    // Empty placeholder
                    ColumnLayout {
                        anchors.centerIn: parent
                        opacity: S.NotificationState.trackedNotifs.length === 0 ? 1 : 0
                        visible: opacity != 0
                        Behavior on opacity {
                            NumberAnimation {
                                duration: C.Config.anim_FAST
                                easing.type: Easing.Linear
                            }
                        }
                        CW.FontIcon {
                            Layout.alignment: Qt.AlignHCenter
                            text: "notifications_active"
                            iconSize: 64
                            color: C.Config.colors.fg
                        }
                        CW.StyledText {
                            text: qsTr("No notifications")
                            font.pointSize: C.Config.fontSize.large
                            horizontalAlignment: Text.AlignHCenter
                            color: C.Config.colors.fg
                        }
                    }
                }

                Stats {
                    Layout.fillWidth: true
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: C.Config.anim_CURVE_SMOOTH_SLIDE
                    }
                }
            }
        }
    }
}
