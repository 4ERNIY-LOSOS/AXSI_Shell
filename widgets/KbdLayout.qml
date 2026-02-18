import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

Text {
  id: layoutText
  color: "white"
  text: ".."

  Connections {
    target: Hyprland
    function onRawEvent(event) {
      if (event.name === "activelayout") {
        const parts = event.data.split(",");
        if (parts.length > 1) {
          layoutText.text = parts[1].substring(0, 2).toUpperCase();
        }
      }
    }
  }

  Process {
    id: initProcess
    command: ["hyprctl", "devices", "-j"]
    running: true
    stdout: DataStream {
      onRead: {
        try {
          const devices = JSON.parse(text);
          const keyboards = devices.keyboards;
          if (keyboards && keyboards.length > 0) {
            // Try to find the keyboard that has the active keymap
            // or just take the first one for now.
            layoutText.text = keyboards[0].active_keymap.substring(0, 2).toUpperCase();
          }
        } catch (e) {
          console.log("Error parsing hyprctl output: " + e);
        }
      }
    }
  }
}
