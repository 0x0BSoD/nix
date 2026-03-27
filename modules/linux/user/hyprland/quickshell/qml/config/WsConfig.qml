pragma Singleton

import Quickshell
import QtQuick

Singleton {
    property Workspaces config: Workspaces {}

    component Workspaces: QtObject {
        property int totalWs: 5
        property string active: " 󰮯 "
        property string occupied: " 󰊠 ";
        property string empty: "  "
    }
}