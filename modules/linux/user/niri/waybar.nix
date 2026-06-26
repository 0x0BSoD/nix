{ lib, osConfig, ... }: lib.mkIf osConfig.programs.niri.enable {
  xdg.configFile."waybar-niri/config".text = builtins.toJSON {
    layer = "top";
    position = "top";
    exclusive = true;
    passthrough = false;
    spacing = 3;
    fixed-center = true;
    ipc = true;

    margin-top = 0;
    margin-left = 0;
    margin-right = 0;

    modules-left = ["niri/workspaces"];
    modules-center = ["niri/window"];
    modules-right = [
      "cpu"
      "memory"
      "pulseaudio"
      "network"
      "custom/separator"
      "tray"
      "custom/separator"
      "battery"
      "custom/separator"
      "clock"
      "custom/separator"
      "custom/notification"
      "custom/separator"
    ];

    "custom/separator" = {
      format = "";
      interval = "once";
      tooltip = false;
    };

    "niri/workspaces" = {
      on-click = "activate";
      format = "{icon}";
      format-icons = {
        active = "<span font='12'>󰮯</span>";
        empty = "<span font='8'></span>";
        default = "󰊠";
      };
    };

    "niri/window" = {
      format = "{}";
      max-length = 25;
      rewrite = {
        "(.*) — Mozilla Firefox" = " $1";
        "(.*) - ghostty" = "> [$1]";
        "(.*) - zsh" = "> [$1]";
      };
    };

    tray = {
      icon-size = 15;
      spacing = 7;
    };

    clock = {
      interval = 1;
      format = "{:%H:%M}";
      format-alt = " {:%H:%M   %Y, %d %B, %A}";
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      calendar = {
        mode = "year";
        mode-mon-col = 3;
        weeks-pos = "right";
        on-scroll = 1;
        format = {
          months = "<span color='#ffead3'><b>{}</b></span>";
          days = "<span color='#ecc6d9'><b>{}</b></span>";
          weeks = "<span color='#99ffdd'><b>W{:%V}</b></span>";
          weekdays = "<span color='#ffcc66'><b>{}</b></span>";
          today = "<span color='#ff6699'><b><u>{}</u></b></span>";
        };
      };
    };

    pulseaudio = {
      format = "{icon}  {volume}%";
      tooltip-format = "Playing at {volume}%";
      format-muted = "  Muted";
      on-click = "ghostty --class=wiremix -e wiremix";
      on-click-right = "pamixer -t";
      on-scroll-up = "pamixer -i 1";
      on-scroll-down = "pamixer -d 1";
      scroll-step = 5;
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = ["" "" "" ""];
      };
    };

    memory = {
      states = {c = 90; h = 60; m = 30;};
      interval = 10;
      format = " {used}GB";
      format-m = "󰾅 {used}GB";
      format-h = "󰓅 {used}GB";
      format-c = " {used}GB";
      format-alt = "󰾆 {percentage}%";
      max-length = 10;
      tooltip = true;
      tooltip-format = "󰾆 {percentage}%\n {used:0.1f}GB/{total:0.1f}GB";
    };

    cpu = {
      interval = 1;
      format = " {usage:>2}% {icon0}{icon1}{icon2}{icon3}";
      format-icons = ["⣀" "⣀" "⣄" "⣤" "⣦" "⣶" "⣷" "⣿"];
    };

    network = {
      tooltip = true;
      format-wifi = "  ";
      format-ethernet = "󰈀 ";
      tooltip-format = "Network: <big><b>{essid}</b></big>\nSignal strength: <b>{signaldBm}dBm ({signalStrength}%)</b>\nFrequency: <b>{frequency}MHz</b>\nInterface: <b>{ifname}</b>\nIP: <b>{ipaddr}/{cidr}</b>\nGateway: <b>{gwaddr}</b>\nNetmask: <b>{netmask}</b>";
      format-linked = "󰈀 {ifname} (No IP)";
      format-disconnected = "󰖪 ";
      tooltip-format-disconnected = "Disconnected";
      format-alt = "<span foreground='#99ffdd'> {bandwidthDownBytes}</span> <span foreground='#ffcc66'> {bandwidthUpBytes}</span>";
      interval = 2;
    };

    battery = {
      bat = "BAT0";
      interval = 60;
      states = {warning = 30; critical = 15;};
      events = {
        on-discharging-warning = "notify-send -u normal 'Low Battery'";
        on-discharging-critical = "notify-send -u critical 'Very Low Battery'";
        on-charging-100 = "notify-send -u normal 'Battery Full!'";
      };
      format = "{capacity}% {icon} ";
      format-icons = ["" "" "" "" ""];
      max-length = 25;
    };

    "custom/notification" = {
      tooltip = true;
      tooltip-format = "Notifications";
      format = "{icon} ";
      format-icons = {
        notification = "<span foreground='red'><sup></sup></span>";
        none = "";
        dnd-notification = "<span foreground='red'><sup></sup></span>";
        dnd-none = "";
        inhibited-notification = "<span foreground='red'><sup></sup></span>";
        inhibited-none = "";
        dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
        dnd-inhibited-none = "";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      on-click = "swaync-client -t -sw";
      on-click-right = "swaync-client -d -sw";
      escape = true;
    };
  };
}
