import QtQuick
import qs.config

Rectangle {
    default property alias content: inner.children
    property int hPad: 12

    color: ColorsConfig.palette.current.primary_container
    height: parent.height
    implicitWidth: inner.implicitWidth + hPad * 2

    Row {
        id: inner
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: parent.hPad
        }
        spacing: 6
    }
}
