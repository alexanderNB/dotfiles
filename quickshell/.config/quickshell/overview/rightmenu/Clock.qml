import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import "../../config" as C
import "../../bar" as B
import "../../state" as S

ColumnLayout {
    id: root

    property var time: C.Config.formatDateTimeSplit(clock.date)
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Text {
        text: time[1]

        Layout.fillWidth: true

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: C.Config.fontSize.huge
        color: C.Config.colors.fg
    }

    Text {
        text: time[0]

        Layout.fillWidth: true

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: C.Config.fontSize.small
        color: C.Config.colors.fg
    }
}
