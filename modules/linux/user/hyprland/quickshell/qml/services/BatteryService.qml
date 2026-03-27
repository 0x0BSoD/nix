pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property int capacity: 100
    property string status: "Unknown"
    property bool charging: false

    Timer {
        running: true
        interval: 30000
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            capacityFile.reload();
            statusFile.reload();
        }
    }

    FileView {
        id: capacityFile
        path: "/sys/class/power_supply/BAT0/capacity"
        onLoaded: root.capacity = parseInt(text(), 10) || 0
    }

    FileView {
        id: statusFile
        path: "/sys/class/power_supply/BAT0/status"
        onLoaded: {
            root.status = text().trim();
            root.charging = root.status === "Charging" || root.status === "Full";
        }
    }
}
