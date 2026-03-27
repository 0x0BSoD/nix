pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property int volume: 0
    property bool muted: false

    function setVolume(delta: int) {
        const cmd = delta > 0
            ? `pamixer -i ${Math.abs(delta)}`
            : `pamixer -d ${Math.abs(delta)}`;
        adjustVol.command = ["sh", "-c", cmd];
        adjustVol.running = true;
    }

    function toggleMute() {
        adjustVol.command = ["sh", "-c", "pamixer -t"];
        adjustVol.running = true;
    }

    Process {
        id: adjustVol
        onRunningChanged: {
            if (!running)
                refresh.running = true;
        }
    }

    Process {
        id: refresh
        command: ["sh", "-c", "pamixer --get-volume; pamixer --get-mute"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const lines = this.text.trim().split("\n");
                root.volume = parseInt(lines[0], 10) || 0;
                root.muted = lines[1]?.trim() === "true";
                refresh.running = false;
            }
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: refresh.running = true
    }
}
