import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire

Row {
  id: root
  spacing: 5

  Text {
    color: "white"
    font.pixelSize: 14
    text: {
      if (!Pipewire.defaultAudioSink || !Pipewire.defaultAudioSink.audio) return "Audio: --";
      const vol = Math.round(Pipewire.defaultAudioSink.audio.volume * 100);
      return `Vol: ${vol}%`;
    }
  }

  TapHandler {
    onTapped: sinkMenu.popup()
  }

  Menu {
    id: sinkMenu

    Repeater {
      model: Pipewire.nodes
      delegate: MenuItem {
        required property var modelData
        // Only show actual hardware sinks, not streams
        visible: modelData.isSink && !modelData.isStream
        text: modelData.description
        highlighted: modelData === Pipewire.defaultAudioSink
        onTriggered: Pipewire.preferredDefaultAudioSink = modelData
      }
    }
  }
}
