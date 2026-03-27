import QtQuick

import qs.components
import qs.services
import qs.config

Row {
    spacing: 6

    StyledText {
        height: parent.height
        bottomPadding: 3
        width: 36
        text: `${BatteryService.capacity} %`
        color: BatteryService.capacity <= 15 && !BatteryService.charging
            ? ColorsConfig.palette.current.accent_red
            : ColorsConfig.palette.current.text
    }

    MaterialIcon {
        readonly property string icon: {
            if (BatteryService.charging) return "Battery_Charging_Full";
            if (BatteryService.capacity >= 80) return "Battery_Full";
            if (BatteryService.capacity >= 60) return "Battery_5_Bar";
            if (BatteryService.capacity >= 40) return "Battery_3_Bar";
            if (BatteryService.capacity >= 20) return "Battery_1_Bar";
            return "Battery_Alert";
        }
        text: icon
        height: parent.height
        fill: 0
        color: BatteryService.capacity <= 15 && !BatteryService.charging
            ? ColorsConfig.palette.current.accent_red
            : BatteryService.charging
                ? ColorsConfig.palette.current.accent_green
                : ColorsConfig.palette.current.text
    }
}
