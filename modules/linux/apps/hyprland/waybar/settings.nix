{...}: {
  programs.waybar.settings.mainBar = {
    position = "top";
    layer = "top";

    margin-bottom = -10;

    modules-left = [
      "hyprland/workspaces"
      "cpu"
    ];

    modules-center = [
      "clock"
    ];

    modules-right = [
      "bluetooth"
      "network"
      "pulseaudio"
    ];

    #================================

    "hyprland/workspaces" = {
      format = "{name}: {icon}";
      format-icons = {
        active = "";
        default = "";
      };
    };

    network = {
      format-wifi = "󰤢";
      format-ethernet = "󰈀 ";
      format-disconnected = "󰤠 ";
      interval = 5;
      tooltip-format = "{essid} ({signalStrength}%)";
      on-click = "nm-connection-editor";
    };

    cpu = {
      interval = 1;
      format = "  {icon0}{icon1}{icon2}{icon3} {usage:>2}%";
      format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
      on-click = "ghostty -e htop";
    };

    bluetooth = {
      format = "󰂲";
      format-on = "{icon}";
      format-off = "{icon}";
      format-connected = "{icon}";
      format-icons = {
        on = "󰂯";
        off = "󰂲";
        connected = "󰂱";
      };
      on-click = "blueman-manager";
      tooltip-format-connected = "{device_enumerate}";
    };
  };
}
