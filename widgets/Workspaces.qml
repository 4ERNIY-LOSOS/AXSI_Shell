import QtQuick
import Quickshell
import Quickshell.Hyprland

Row {
  spacing: 5

  Repeater {
    model: Hyprland.workspaces

    Rectangle {
      required property var modelData
      width: 20
      height: 20
      radius: 10
      color: modelData === Hyprland.focusedWorkspace ? "#89b4fa" : "#45475a"

      Text {
        anchors.centerIn: parent
        text: modelData.id
        color: "white"
        font.pixelSize: 12
      }

      TapHandler {
        onTapped: Hyprland.dispatch(`workspace ${modelData.id}`)
      }
    }
  }
}
