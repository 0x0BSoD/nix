import QtQuick

import qs.components
import qs.services
import qs.config

Item {
    id: volRoot
    height: parent.height
    implicitWidth: row.implicitWidth

    Row {
        id: row
        anchors.verticalCenter: parent.verticalCenter
        spacing: 6

        MaterialIcon {
            text: AudioService.muted ? "Volume_Off"
                : AudioService.volume >= 66 ? "Volume_Up"
                : AudioService.volume >= 33 ? "Volume_Down"
                : "Volume_Mute"
            height: volRoot.height
            fill: 0
            color: AudioService.muted
                ? ColorsConfig.palette.current.text_muted
                : ColorsConfig.palette.current.text
        }

        StyledText {
            height: volRoot.height
            bottomPadding: 3
            width: 36
            text: AudioService.muted ? "mute" : `${AudioService.volume} %`
            color: AudioService.muted
                ? ColorsConfig.palette.current.text_muted
                : ColorsConfig.palette.current.text
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => {
            if (mouse.button === Qt.RightButton)
                AudioService.toggleMute();
        }
        onWheel: wheel => {
            AudioService.setVolume(wheel.angleDelta.y > 0 ? 2 : -2);
        }
    }
}
