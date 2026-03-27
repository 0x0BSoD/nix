pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string wifiName: ""

    Process {
        id: getWifiName
        command: ["sh", "-c", "nmcli -t -f active,ssid dev wifi | awk -F: '/^yes:/{print $2}'"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                root.wifiName = this.text.trim();
                getWifiName.running = false;
            }
        }
    }

    Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: getWifiName.running = true
    }
}
