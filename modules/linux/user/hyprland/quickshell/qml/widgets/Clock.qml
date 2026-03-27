import QtQuick

import qs.components

Row {
    spacing: 6

    // MaterialIcon {
    //     text: "Schedule"
    //     height: parent.height
    //     fill: 0
    // }

    StyledText {
        id: clockText
        height: parent.height
        bottomPadding: 3

        property var now: new Date()
        text: Qt.formatTime(now, "HH:mm")

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clockText.now = new Date()
        }
    }
}
