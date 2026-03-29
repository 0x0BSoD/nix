import QtQuick
import Quickshell.Bluetooth

import qs.config
import qs.components
import qs.services

Row {
    spacing: 10

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
