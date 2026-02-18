import QtQuick
import QtQuick.Layouts
import "../config" as C

Text {
    id: root
    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter
    property real fontSize: C.Config.fontSize.normal

    font {
        hintingPreference: Font.PreferFullHinting
        pointSize: root.fontSize
        family: C.Config.font.main
        bold: true
    }
    color: C.Config.colors.fg
    linkColor: C.Config.colors.fg
}
