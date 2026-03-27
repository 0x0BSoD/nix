pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property NordPalette nordPalette: NordPalette {}
    readonly property OrangePalette orangePalette: OrangePalette {}
    readonly property DarkBluePalette darkBluePalette: DarkBluePalette {}
    readonly property BlackWhitePalette blackWhitePalette: BlackWhitePalette {}

    component NordPalette: QtObject {
        property color bar_background: "#2E3440"        // nord0
        property color primary_container: "#2E3440"        // nord0
        //property color primary_container: "#3B4252"     // nord1
        property color secondary_container: "#434C5E"   // nord2

        // Text
        property color text: "#ECEFF4"                  // nord6
        property color text_muted: "#D8DEE9"            // nord4

        // Accents
        property color slider: "#88C0D0"                // nord8
        property color accent: "#81A1C1"                // nord9
        property color accent_green: "#A3BE8C"          // nord14
        property color accent_red: "#BF616A"            // nord11
        property color accent_yellow: "#EBCB8B"         // nord13

        // Workspaces
        property color active_ws: "#ECEFF4"             // nord6
        property color occupied_ws: "#88C0D0"           // nord8
        property color empty_ws: "#4C566A"              // nord3
    }

    component OrangePalette: QtObject {
        property color bar_background: "#1a120d"
        property color primary_container: "#281d15"
        property color secondary_container: "#5c4132"
        property color text: "#f0dfd7"
        property color text_muted: "#8a6e62"
        property color slider: "#ffb68e"
        property color accent: "#ffb68e"
        property color accent_green: "#a3be8c"
        property color accent_red: "#bf616a"
        property color accent_yellow: "#ebcb8b"

        // Workspaces
        property color active_ws: "#f0dfd7"
        property color occupied_ws: "#ffb68e"
        property color empty_ws: "#432b1d"
    }

    component DarkBluePalette: QtObject {
        property color bar_background: "#0e1514"
        property color primary_container: "#102a29"
        property color secondary_container: "#5f7a79"
        property color text: "#ffffff"
        property color text_muted: "#7a9a99"
        property color slider: "#96ebe9"
        property color accent: "#96ebe9"
        property color accent_green: "#a3be8c"
        property color accent_red: "#bf616a"
        property color accent_yellow: "#ebcb8b"

        // Workspaces
        property color active_ws: "#ffffff"
        property color occupied_ws: "#90a2a1"
        property color empty_ws: "#274f4e"
    }

    component BlackWhitePalette: QtObject {
        property color bar_background: "#ffffff"
        property color primary_container: "#e6e6e6"
        property color secondary_container: "#b5b5b5"
        property color text: "#1b1b1b"
        property color text_muted: "#7a7a7a"
        property color slider: "#7a7a7a"
        property color accent: "#444444"
        property color accent_green: "#2e7d32"
        property color accent_red: "#c62828"
        property color accent_yellow: "#f9a825"

        // Workspaces
        property color active_ws: "#1b1b1b"
        property color occupied_ws: "#7a7a7a"
        property color empty_ws: "#c2c2c2"
    }
}
