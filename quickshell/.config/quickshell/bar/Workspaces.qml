import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Hyprland
import "../config" as C
import "../commonwidgets" as CW

OffsetMouseWrapper {
    id: root

    property real padding: height / 4
    property real topInset: 0
    property real bottomInset: 0

    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(QsWindow.window?.screen)
    readonly property int activeWorkspace: monitor?.activeWorkspace?.id ?? 1
    property int shownWorkspaces: 10
    property int baseWorkspace: Math.floor((activeWorkspace - 1) / shownWorkspaces) * shownWorkspaces + 1

    Timer {
        id: repeatTimer
        property int repeatCount: 8
        property int currentCount: 0
        interval: 50
        repeat: false
        onTriggered: {
            if (!windowProc.running)
                windowProc.running = true;
            if (currentCount < repeatCount) {
                currentCount++;
                repeatTimer.start();
            }
        }
    }
    Connections {
        target: Hyprland
        function onRawEvent(event) {
            repeatTimer.currentCount = 0;
            repeatTimer.stop();
            repeatTimer.triggered();
        // repeatTimer.start();
        }
    }

    Process {
        id: windowProc
        running: false
        command: ["sh", "-c", "hyprctl -j clients"]

        stdout: SplitParser {
            splitMarker: ""
            onRead: data => {
                try {
                    var clients = JSON.parse(data);
                } catch (e) {
                    // console.log(e);
                    return;
                }

                for (var i = 0; i < root.windows.length; i++) {
                    root.windows[i].value = " " + (i % 10) + " ";
                }
                for (let i = 0; i < clients.length; i++) {
                    let workspace = parseInt(clients[i].workspace.name);
                    if (workspace) {
                        workspace--;
                        if (!root.windows[workspace].value.includes("|")) {
                            // root.windows[workspace].value = root.windows[workspace].value[0] + "|";
                            root.windows[workspace].value = root.windows[workspace].value[1] + "|";
                        }
                        let initialClass = clients[i].initialClass;
                        let title = clients[i].title;
                        switch (initialClass) {
                        case "firefox":
                            if (/.*github.*/i.test(title)) {
                                root.windows[workspace].value += "";
                            } else if (/.*youtube.*/i.test(title)) {
                                root.windows[workspace].value += "";
                            } else if (/.*nvim.*/i.test(title)) {
                                root.windows[workspace].value += "";
                            } else if (/.*neovim.*/i.test(title)) {
                                root.windows[workspace].value += "";
                            } else if (/.*overleaf.*/i.test(title)) {
                                root.windows[workspace].value += "\u0082";
                            } else if (/.*dtu.*/i.test(title)) {
                                root.windows[workspace].value += "󰑴";
                            } else if (/.*studie.*/i.test(title)) {
                                root.windows[workspace].value += "󰑴";
                            } else if (/.*42620.*/i.test(title)) {
                                root.windows[workspace].value += "󰑴";
                            } else {
                                root.windows[workspace].value += "󰈹";
                            }
                            break;
                        case "com.mitchellh.ghostty":
                            if (/.*nvim.*/i.test(title)) {
                                root.windows[workspace].value += "";
                            } else {
                                root.windows[workspace].value += "";
                            }
                            break;
                        case "kitty":
                            if (/.*nvim.*/i.test(title)) {
                                root.windows[workspace].value += "";
                            } else {
                                root.windows[workspace].value += "";
                            }
                            break;
                        case "obsidian":
                            root.windows[workspace].value += "\u0080";
                            break;
                        case "discord":
                            root.windows[workspace].value += "";
                            break;
                        case "steam":
                            root.windows[workspace].value += "";
                            break;
                        case "codium":
                            root.windows[workspace].value += "\u0081";
                            break;
                        case "org.kde.dolphin":
                            root.windows[workspace].value += "󱢴";
                            break;
                        default:
                            root.windows[workspace].value += "";
                        }
                        root.windows[workspace].value += " ";
                    }
                }
            }
        }
    }

    // trackpads
    property int scrollAccumulator: 0

    QtObject {
        id: window0
        property string value: "0"
    }
    QtObject {
        id: window1
        property string value: "1"
    }
    QtObject {
        id: window2
        property string value: "2"
    }
    QtObject {
        id: window3
        property string value: "3"
    }
    QtObject {
        id: window4
        property string value: "4"
    }
    QtObject {
        id: window5
        property string value: "5"
    }
    QtObject {
        id: window6
        property string value: "6"
    }
    QtObject {
        id: window7
        property string value: "7"
    }
    QtObject {
        id: window8
        property string value: "8"
    }
    QtObject {
        id: window9
        property string value: "9"
    }
    QtObject {
        id: window10
        property string value: "10"
    }
    QtObject {
        id: window11
        property string value: "11"
    }
    QtObject {
        id: window12
        property string value: "12"
    }
    QtObject {
        id: window13
        property string value: "13"
    }
    QtObject {
        id: window14
        property string value: "14"
    }
    QtObject {
        id: window15
        property string value: "15"
    }
    QtObject {
        id: window16
        property string value: "16"
    }
    QtObject {
        id: window17
        property string value: "17"
    }
    QtObject {
        id: window18
        property string value: "18"
    }
    QtObject {
        id: window19
        property string value: "19"
    }
    property var windows: [window0, window1, window2, window3, window4, window5, window6, window7, window8, window9, window10, window11, window12, window13, window14, window15, window16, window17, window18, window19]

    acceptedButtons: Qt.NoButton
    onWheel: event => {
        event.accepted = true;
        let acc = scrollAccumulator - event.angleDelta.x - event.angleDelta.y;
        const sign = Math.sign(acc);
        acc = Math.abs(acc);

        const offset = sign * Math.floor(acc / 120);
        scrollAccumulator = sign * (acc % 120);

        if (offset != 0) {
            const currentWorkspace = root.activeWorkspace;
            const targetWorkspace = currentWorkspace + offset;
            const id = Math.max(baseWorkspace, Math.min(baseWorkspace + shownWorkspaces - 1, targetWorkspace));
            if (id != currentWorkspace)
                Hyprland.dispatch(`workspace ${id}`);
        }
    }

    Row {
        spacing: 0

        Repeater {
            model: ScriptModel {
                objectProp: "index"
                values: {
                    const workspaces = Hyprland.workspaces.values;
                    const base = root.baseWorkspace;
                    return Array.from({
                        length: root.shownWorkspaces
                    }, (_, i) => ({
                                index: i,
                                workspace: workspaces.find(w => w.id == base + i)
                            }));
                }
            }

            WrapperMouseArea {
                id: delegate
                required property var modelData

                implicitHeight: parent.height
                leftMargin: 0
                rightMargin: 0
                topMargin: root.topInset + root.padding
                bottomMargin: root.bottomInset + root.padding

                onPressed: Hyprland.dispatch(`workspace ${modelData.index + root.baseWorkspace}`)

                Rectangle {
                    radius: height / 2
                    implicitWidth: delegate.modelData.workspace ? text.implicitWidth + 5 : 0
                    color: "transparent"

                    CW.StyledText {
                        id: text
                        // visible: C.Config.settings.bar.workspaces.style != 0
                        visible: delegate.modelData.workspace ? 1 : 0

                        text: root.windows[modelData.index + root.baseWorkspace - 1].value

                        // text: C.Config.settings.bar.workspaces.style == 1 ? "" + modelData.index : C.Config.romanize(modelData.index)
                        anchors {
                            top: parent.top
                            bottom: parent.bottom
                        }
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pointSize: C.Config.fontSize.normal
                        color: delegate.modelData.workspace?.active ? C.Config.theme.on_surface : delegate.modelData.workspace ? Qt.darker(C.Config.theme.outline, 1.4) : Qt.lighter(C.Config.theme.outline, 1.4)

                        Behavior on color {
                            ColorAnimation {
                                duration: C.Globals.anim_SLOW
                                easing.type: Easing.BezierSpline
                                easing.bezierCurve: C.Globals.anim_CURVE_SMOOTH_SLIDE
                            }
                        }
                    }
                }
            }
        }
    }
}
