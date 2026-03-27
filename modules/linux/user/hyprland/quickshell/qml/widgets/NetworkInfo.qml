import QtQuick
import Quickshell.Bluetooth

import qs.config
import qs.components
import qs.services

Row {
    spacing: 10

    // Bluetooth icon
    Row {
        id: btRow
        spacing: 6
        height: parent.height

        property var btDevices: Bluetooth.defaultAdapter?.devices?.values
        property var firstDevice: btDevices?.[0]

        MaterialIcon {
            text: btRow.firstDevice?.connected ? "Bluetooth" : "Bluetooth_Disabled"
            height: parent.height
            fill: btRow.firstDevice?.connected ? 1 : 0
            color: btRow.firstDevice?.connected
                ? ColorsConfig.palette.current.accent
                : ColorsConfig.palette.current.text_muted
        }
    }

    // WiFi
    Row {
        id: wifiRow
        spacing: 6
        height: parent.height

        MaterialIcon {
            text: Wifi.wifiName !== "" ? "Wifi" : "Wifi_Off"
            height: parent.height
            fill: 0
        }
        StyledText {
            height: parent.height
            bottomPadding: 3
            text: Wifi.wifiName !== "" ? Wifi.wifiName : "disconnected"
            color: Wifi.wifiName !== ""
                ? ColorsConfig.palette.current.text
                : ColorsConfig.palette.current.text_muted
            maximumLineCount: 1
            elide: Text.ElideRight
            width: Math.min(implicitWidth, 120)
        }
    }
}
