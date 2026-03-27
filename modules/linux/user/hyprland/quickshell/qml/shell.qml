import Quickshell
import QtQuick

import qs.config
import qs.widgets

Variants {
    id: root
    model: Quickshell.screens

    PanelWindow {
        id: mainWindow
        required property var modelData
        screen: modelData
        anchors {
            top: true
            left: true
            right: true
        }
        implicitHeight: 32

        Rectangle {
            id: bar
            anchors.fill: parent
            color: ColorsConfig.palette.current.bar_background

            // Left section
            Row {
                id: leftSection
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                    leftMargin: 8
                }
                spacing: 6

                // Workspaces
                Rectangle {
                    color: ColorsConfig.palette.current.primary_container
                    height: parent.height
                    implicitWidth: wsWidget.implicitWidth + 20
                    Workspaces {
                        id: wsWidget
                        anchors {
                            fill: parent
                            leftMargin: 10
                            rightMargin: 10
                        }
                    }
                }

            }

            // Center section — pinned to the screen center
            Row {
                id: centerSection
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    bottom: parent.bottom
                }
                spacing: 6

            }

            // Right section
            Row {
                id: rightSection
                anchors {
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                    rightMargin: 8
                }
                spacing: 6
                layoutDirection: Qt.RightToLeft

                // Notifications
                Rectangle {
                    color: ColorsConfig.palette.current.primary_container
                    height: parent.height
                    implicitWidth: notifWidget.implicitWidth + 24
                    Notifications {
                        id: notifWidget
                        anchors {
                            fill: parent
                            leftMargin: 12
                            rightMargin: 12
                        }
                    }
                }

                // Clock
                Rectangle {
                    color: ColorsConfig.palette.current.primary_container
                    height: parent.height
                    implicitWidth: clockWidget.implicitWidth + 24
                    Clock {
                        id: clockWidget
                        anchors {
                            fill: parent
                            leftMargin: 12
                            rightMargin: 12
                        }
                    }
                }

                // Battery
                Rectangle {
                    color: ColorsConfig.palette.current.primary_container
                    height: parent.height
                    implicitWidth: batWidget.implicitWidth + 24
                    Battery {
                        id: batWidget
                        anchors {
                            fill: parent
                            leftMargin: 12
                            rightMargin: 12
                        }
                    }
                }

                // Volume
                Rectangle {
                    color: ColorsConfig.palette.current.primary_container
                    height: parent.height
                    implicitWidth: volWidget.implicitWidth + 24
                    Volume {
                        id: volWidget
                        anchors {
                            fill: parent
                            leftMargin: 12
                            rightMargin: 12
                        }
                    }
                }

                // WiFi + Bluetooth
                Rectangle {
                    color: ColorsConfig.palette.current.primary_container
                    height: parent.height
                    implicitWidth: netWidget.implicitWidth + 24
                    NetworkInfo {
                        id: netWidget
                        anchors {
                            fill: parent
                            leftMargin: 12
                            rightMargin: 12
                        }
                    }
                }

                // CPU + RAM
                Rectangle {
                    color: ColorsConfig.palette.current.primary_container
                    height: parent.height
                    implicitWidth: sysWidget.implicitWidth + 24
                    SystemInfo {
                        id: sysWidget
                        anchors {
                            fill: parent
                            leftMargin: 12
                            rightMargin: 12
                        }
                    }
                }
            }
        }
    }
}
