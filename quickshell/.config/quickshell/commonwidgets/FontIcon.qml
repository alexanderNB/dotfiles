import QtQuick
import "../config" as C
import "../state" as S

Text {
  id: root
  property real fill: 0
  property real iconSize: 18
  color: C.Config.theme.on_surface
  font {
    family: C.Globals.isFedora ? "Material Icons Outlined" : "Material Symbols Outlined"
    pixelSize: root.iconSize
    variableAxes: {
      "FILL": root.fill,
      "opsz": root.iconSize
    }
  }
}
