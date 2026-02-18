import QtQuick
import "../config" as C
import "../state" as S

Text {
    id: root
    property real fill: 0
    property real iconSize: 18
    color: C.Config.colors.fg
    font {
        family: C.Config.font.symbol
        // TODO: make pixelSize consitant
        pointSize: root.iconSize
        variableAxes: {
            "FILL": root.fill,
            "opsz": root.iconSize
        }
    }
}
