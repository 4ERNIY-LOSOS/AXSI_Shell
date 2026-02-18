import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

Row {
  spacing: 8

  Repeater {
    model: SystemTray.items

    Item {
      required property var modelData
      width: 20
      height: 20

      IconImage {
        anchors.fill: parent
        source: modelData.icon
        fillMode: Image.PreserveAspectFit
      }

      TapHandler {
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onTapped: (event) => {
          if (button === Qt.LeftButton) {
            modelData.activate(0, 0);
          } else if (button === Qt.RightButton) {
            modelData.contextMenu(0, 0);
          }
        }
      }

      HoverHandler {
        id: hover
      }

      ToolTip.visible: hover.hovered
      ToolTip.text: modelData.title || ""
      ToolTip.delay: 500
    }
  }
}
