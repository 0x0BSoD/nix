pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property string title: ""
    property string appClass: ""

    Connections {
        target: Hyprland

        function onRawEvent(event) {
            if (event.name === "activewindow") {
                const parts = event.parse(2);
                root.appClass = parts[0] ?? "";
                root.title = parts[1] ?? "";
            } else if (
                event.name === "activewindowv2" ||
                event.name === "closewindow" ||
                event.name === "openwindow"
            ) {
                titleQuery.running = true;
            }
        }
    }

    Process {
        id: titleQuery
        command: ["sh", "-c", "hyprctl activewindow -j 2>/dev/null | jq -r '.title // \"\"'"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.title = this.text.trim();
                titleQuery.running = false;
            }
        }
    }
}
