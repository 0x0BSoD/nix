import Quickshell
import Quickshell.Hyprland
import QtQuick

import qs.config
import qs.components

Row {
    id: wsRow

    readonly property var currentScreen: Hyprland.monitorFor(wsRow.QsWindow.window?.screen)
    readonly property var occupied: Hyprland.workspaces.values

    spacing: 0

    Repeater {
        model: WsConfig.config.totalWs

        Item {
            id: wsContainer
            required property int index

            readonly property bool isOccupied: wsRow.occupied.some(e => e.id === index + 1)
            readonly property bool isOnScreen: wsRow.occupied.some(e => e?.id === index + 1 && e?.monitor?.id === wsRow.currentScreen?.id)
            readonly property bool isActive: wsRow.occupied.some(e => e?.id === index + 1 && e?.monitor?.id === wsRow.currentScreen?.id && e.active)

            property int fontSize: 21

            height: wsRow.height
            width: 30

            MaterialIcon {
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: wsContainer.isActive ? WsConfig.config.active
                     : wsContainer.isOccupied ? WsConfig.config.occupied
                     : WsConfig.config.empty
                font.pixelSize: wsContainer.fontSize
                fill: wsContainer.isActive ? 1 : 0
                text: WsConfig.config.label
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    const ws = wsContainer.index + 1;
                    if (Hyprland.activeWsId !== ws)
                        Hyprland.dispatch(`workspace ${ws}`);
                }
                onEntered: wsContainer.fontSize = 23
                onExited: wsContainer.fontSize = 21
            }
        }
    }
}
