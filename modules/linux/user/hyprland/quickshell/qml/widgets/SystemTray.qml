import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

import qs.components
import qs.services

RowLayout {
    id: trayLayout
    anchors.centerIn: parent
    spacing: 10

    Repeater {
        id: trayRepeater
        model: SystemTray.items

        delegate: Image {
            id: trayIcon
            source: modelData.icon || ""
            fillMode: Image.PreserveAspectFit

            sourceSize: Qt.size(18, 18)
            Layout.preferredWidth: 18
            Layout.preferredHeight: 18
            Layout.alignment: Qt.AlignVCenter
        }
    }
}