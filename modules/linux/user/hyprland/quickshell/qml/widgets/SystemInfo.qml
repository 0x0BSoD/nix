import QtQuick

import qs.components
import qs.services

Row {
    spacing: 6

    MaterialIcon {
        text: "Laptop_Windows"
        height: parent.height
        fill: 0
    }

    StyledText {
        width: 44
        height: parent.height
        bottomPadding: 3
        text: `${Math.round(SystemUsage.cpuPerc * 100)} %`
    }

    MaterialIcon {
        text: "Memory"
        height: parent.height
        fill: 0
    }
    StyledText {
        width: 52
        height: parent.height
        bottomPadding: 3
        text: {
            const ram = SystemUsage.formatKib(SystemUsage.ramUsed);
            return `${+ram.value.toFixed(1)}${ram.unit}`;
        }
    }
}
