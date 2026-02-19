//@ pragma UseQApplication
//@ pragma IgnoreSystemSettings
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import "state" as S
import "bar" as B
import "notifs" as N
import "osd" as O
import "overview" as OV
import "config" as C

Scope {
    Component.onCompleted: {
        console.log("Shell initialized");
    }

    Variants {
        model: {
            let mons = Quickshell.screens;
            if (mons.length == 0) {
                return [Quickshell.screens[0]]; // prevent a softlock
            }
            return mons;
        }

        Item {
            required property ShellScreen modelData

            B.Bar {
                screen: modelData
            }

            N.NotificationPanel {
                screen: modelData
            }

            // TODO: Set up config
            //
        }
    }
    O.VolumeOSD {}
    OV.Overview {}
}
