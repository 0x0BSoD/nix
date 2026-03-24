import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Services.SystemTray

PanelWindow {
    id: barWindow

    anchors {
        top: true
        left: true
        right: true
    }

    height: 48
    margins {
        top: 8
        bottom: 0
        left: 4
        right: 4
    }

    exclusiveZone: 52
    color: "transparent"

    Colors {
        id: mocha
    }

    property bool isStartupReady: false
    Timer {
        interval: 10
        running: true
        onTriggered: barWindow.isStartupReady = true
    }

    property string timeStr: ""
    property string fullDateStr: ""
    property int typeInIndex: 0
    property string dateStr: fullDateStr.substring(0, typeInIndex)

    property string weatherIcon: ""
    property string weatherTemp: "--°"
    property string weatherHex: "#f9e2af"

    property string wifiStatus: "Off"
    property string wifiIcon: "󰤮"
    property string wifiSsid: ""

    property string btStatus: "Off"
    property string btIcon: "󰂲"
    property string btDevice: ""

    property string volPercent: "0%"
    property string volIcon: "󰕾"
    property bool isMuted: false
    property string batPercent: "100%"
    property string batIcon: "󰁹"
    property string kbLayout: "us"

    property var workspacesData: []
    property var musicData: {
        "status": "Stopped",
        "title": "",
        "artUrl": "",
        "timeStr": ""
    }

    // ====================================================================

    property bool isMediaActive: barWindow.musicData.status !== "Stopped" && barWindow.musicData.title !== ""
    property bool isWifiOn: barWindow.wifiStatus.toLowerCase() === "enabled" || barWindow.wifiStatus.toLowerCase() === "on"
    property bool isBtOn: barWindow.btStatus.toLowerCase() === "enabled" || barWindow.btStatus.toLowerCase() === "on"

    Process {
        id: wsDaemon
        command: ["bash", "-c", "workspaces > /tmp/qs_workspaces.json"]
        running: true
    }

    Process {
        id: wsPoller
        command: ["bash", "-c", "tail -n 1 /tmp/qs_workspaces.json 2>/dev/null"]
        stdout: StdioCollector {
            onStreamFinished: {
                let txt = this.text.trim();
                if (txt !== "") {
                    try {
                        barWindow.workspacesData = JSON.parse(txt);
                    } catch (e) {}
                }
            }
        }
    }
    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: wsPoller.running = true
    }

    Item {
        anchors.fill: parent

        RowLayout {
            id: leftLayout
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            spacing: 4

            // Decoupled Main Transition
            property bool showLayout: false
            opacity: showLayout ? 1 : 0
            transform: Translate {
                x: leftLayout.showLayout ? 0 : -20
                Behavior on x {
                    NumberAnimation {
                        duration: 600
                        easing.type: Easing.OutCubic
                    }
                }
            }

            Timer {
                running: barWindow.isStartupReady
                interval: 10
                onTriggered: leftLayout.showLayout = true
            }

            Behavior on opacity {
                NumberAnimation {
                    duration: 600
                    easing.type: Easing.OutCubic
                }
            }

            property int moduleHeight: 48

            // Workspaces
            Rectangle {
                color: Qt.rgba(mocha.base.r, mocha.base.g, mocha.base.b, 0.75)
                radius: 14
                border.width: 1
                border.color: Qt.rgba(mocha.text.r, mocha.text.g, mocha.text.b, 0.05)
                Layout.preferredHeight: parent.moduleHeight
                clip: true

                property real targetWidth: barWindow.workspacesData.length > 0 ? wsLayout.implicitWidth + 20 : 0
                Layout.preferredWidth: targetWidth
                visible: targetWidth > 0
                opacity: barWindow.workspacesData.length > 0 ? 1 : 0
                Behavior on opacity {
                    NumberAnimation {
                        duration: 300
                    }
                }
                Behavior on targetWidth {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutExpo
                    }
                }

                RowLayout {
                    id: wsLayout
                    anchors.centerIn: parent
                    spacing: 6

                    Repeater {
                        model: barWindow.workspacesData
                        delegate: Rectangle {
                            id: wsPill
                            property bool isHovered: wsPillMouse.containsMouse

                            property real targetWidth: modelData.state === "active" ? 36 : 32
                            Layout.preferredWidth: targetWidth
                            Behavior on targetWidth {
                                NumberAnimation {
                                    duration: 250
                                    easing.type: Easing.OutBack
                                }
                            }

                            Layout.preferredHeight: 32
                            radius: 10

                            // IMPROVED WORKSPACE STATES - Clearer hierarchy for occupied vs empty
                            color: modelData.state === "active" ? mocha.mauve : (isHovered ? Qt.rgba(mocha.surface2.r, mocha.surface2.g, mocha.surface2.b, 0.9) : (modelData.state === "occupied" ? Qt.rgba(mocha.surface1.r, mocha.surface1.g, mocha.surface1.b, 0.9) : "transparent"))

                            // ADDED TACTILE SCALE ANIMATION ON HOVER
                            scale: isHovered && modelData.state !== "active" ? 1.08 : 1.0
                            Behavior on scale {
                                NumberAnimation {
                                    duration: 250
                                    easing.type: Easing.OutBack
                                }
                            }

                            // Safe Instantiation Cascade logic
                            property bool initAnimTrigger: barWindow.startupCascadeFinished
                            opacity: initAnimTrigger ? 1 : 0
                            transform: Translate {
                                y: wsPill.initAnimTrigger ? 0 : 15
                                Behavior on y {
                                    NumberAnimation {
                                        duration: 500
                                        easing.type: Easing.OutBack
                                    }
                                }
                            }

                            Component.onCompleted: {
                                if (!barWindow.startupCascadeFinished) {
                                    animTimer.interval = index * 60;
                                    animTimer.start();
                                }
                            }

                            Timer {
                                id: animTimer
                                running: false
                                repeat: false
                                onTriggered: wsPill.initAnimTrigger = true
                            }

                            Behavior on opacity {
                                NumberAnimation {
                                    duration: 500
                                    easing.type: Easing.OutCubic
                                }
                            }
                            Behavior on color {
                                ColorAnimation {
                                    duration: 250
                                }
                            }

                            Text {
                                anchors.centerIn: parent
                                text: modelData.id
                                font.family: "JetBrains Mono"
                                font.pixelSize: 14
                                font.weight: modelData.state === "active" ? Font.Black : (modelData.state === "occupied" ? Font.Bold : Font.Medium)

                                // IMPROVED TEXT CONTRAST - Pop occupied text to true text color, fade empty out
                                color: modelData.state === "active" ? mocha.crust : (isHovered ? mocha.text : (modelData.state === "occupied" ? mocha.text : mocha.overlay0))

                                Behavior on color {
                                    ColorAnimation {
                                        duration: 250
                                    }
                                }
                            }
                            MouseArea {
                                id: wsPillMouse
                                hoverEnabled: true
                                anchors.fill: parent
                                onClicked: Quickshell.execDetached(["bash", "-c", "~/.config/hypr/scripts/qs_manager.sh " + modelData.id])
                            }
                        }
                    }
                }
            }
        }
    }
}
