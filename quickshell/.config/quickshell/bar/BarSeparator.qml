import QtQuick
import QtQuick.Layouts
import "../config" as C
import "../commonwidgets" as CW

CW.CutRectangle {
    id: root
    property alias size: root.implicitWidth

    size: C.Config.bar.seperatorSize

    color: C.Config.colors.blue7
    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    implicitHeight: size
    radius: size / 2
}
