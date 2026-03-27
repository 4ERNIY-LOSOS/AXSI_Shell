import Quickshell
import QtQuick
import QtQuick.Layouts
import "../widgets"

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 32
      color: "#1e1e2e"

      RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 0

        // Left
        Row {
          Layout.alignment: Qt.AlignLeft
          spacing: 10
          Workspaces {}
        }

        // Center
        Item {
          Layout.fillWidth: true
          Layout.fillHeight: true
          Clock {
            anchors.centerIn: parent
          }
        }

        // Right
        Row {
          Layout.alignment: Qt.AlignRight
          spacing: 15

          KbdLayout {}
          Audio {}
          SysTray {}
        }
      }
    }
  }
}
