import QtQuick
import QtQuick.Layouts
import Quickshell
import "../config" as C
import "../state" as S
import "../commonwidgets" as CW

RowLayout {
    id: root
    spacing: 3

    CW.FontIcon {
        text: S.WeatherState.icon
        iconSize: C.Config.fontSize.smallSymbol
    }

    CW.StyledText {
        text: S.WeatherState.temp + ", " + S.WeatherState.location
        fontSize: C.Config.fontSize.small
    }
}
