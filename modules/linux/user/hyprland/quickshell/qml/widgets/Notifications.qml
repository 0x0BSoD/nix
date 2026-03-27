import QtQuick
import Quickshell.Io

import qs.components
import qs.config

Item {
    id: notifRoot

    height: parent.height
    implicitWidth: row.implicitWidth

    property int count: 0

    Process {
        id: getCount
        command: ["swaync-client", "-c"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const n = parseInt(this.text.trim(), 10);
                notifRoot.count = isNaN(n) ? 0 : n;
                getCount.running = false;
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: getCount.running = true
    }

    Row {
        id: row
        anchors.verticalCenter: parent.verticalCenter
        spacing: 6

        MaterialIcon {
            text: notifRoot.count > 0 ? "Notifications_Active" : "Notifications"
            height: notifRoot.height
            fill: notifRoot.count > 0 ? 1 : 0
            color: notifRoot.count > 0
                ? ColorsConfig.palette.current.accent
                : ColorsConfig.palette.current.text
        }

        StyledText {
            height: notifRoot.height
            bottomPadding: 3
            text: `${notifRoot.count}`
            visible: notifRoot.count > 0
            width: visible ? implicitWidth : 0
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => {
            if (mouse.button === Qt.RightButton)
                toggleDnd.running = true;
            else
                togglePanel.running = true;
        }
    }

    Process {
        id: togglePanel
        command: ["swaync-client", "-t", "-sw"]
    }

    Process {
        id: toggleDnd
        command: ["swaync-client", "-d", "-sw"]
    }
}
