import QtQuick
import QtCore
import Quickshell

import "../commonwidgets" as CW
import "../config" as C

CW.StyledText {
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    text: Qt.formatDateTime(clock.date, C.Config.dateFormat)
}
