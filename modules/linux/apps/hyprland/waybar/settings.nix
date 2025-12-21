{...}: {
  programs.waybar.settings.mainBar = {
    position = "top";
    layer = "top";

    spacing = 4;

    # mode = "dock";
    # exclusive = true;
    # passthrough = false;
    # gtk-layer-shell = true;
    # height = 0;
    # margin-bottom = 10;

    modules-left = [
      "hyprland/workspaces"
      "cpu"
      "memory"
    ];

    modules-center = [
      "hyprland/window"
    ];

    modules-right = [
      "network#spd"
      "pulseaudio"
      "network"
      "tray"
      "battery"
      "clock"
    ];

    #================================
    wireplumber = {
      scroll-step = 10;
      format = "{volume}% {icon}  ";
      format-bluetooth = "{icon} {volume}%";
      format-muted = "muted ";
      on-click = "pavucontrol";
      format-icons = {
        headphones = "";
        handsfree = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = [
          ""
          "󰓃"
        ];
      };
    };

    backlight = {
      device = "intel_backlight";
      format = "{percent}% {icon}";
      format-icons = ["" ""];
    };

    "hyprland/window" = {
      icon = false;
      separate-outputs = true;
      format = "{}";
    };

    "hyprland/workspaces" = {
      disable-scroll = true;
      all-outputs = true;
      on-click = "activate";
      format = "{name}";
      persistent-workspaces = {
        "1" = [];
        "2" = [];
        "3" = [];
      };
    };

    tray = {
      icon-size = 15;
      spacing = 7;
    };

    clock = {
      format = "{:%H:%M}";
      format-alt = "{:%A, %B %d, %Y (%R)}";
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      calendar = {
        mode = "month";
        mode-mon-col = 3;
        on-scroll = 1;
        on-click-right = "mode";
        format = {
          months = "<span color='#a6adc8'><b>{}</b></span>";
          weekdays = "<span color='#a6adc8'><b>{}</b></span>";
          today = "<span color='#a6adc8'><b>{}</b></span>";
          days = "<span color='#555869'><b>{}</b></span>";
        };
      };
    };

    pulseaudio = {
      format = "{icon}  {volume}%";
      tooltip = false;
      format-muted = "  Muted";
      on-click = "pamixer -t";
      on-scroll-up = "pamixer -i 1";
      on-scroll-down = "pamixer -d 1";
      scroll-step = 5;
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = [
          ""
          ""
          ""
          ""
        ];
      };
    };

    memory = {
      states = {
        c = 90;
        h = 60;
        m = 30;
      };
      interval = 10;
      format = "󰾆 {used}GB";
      format-m = "󰾅 {used}GB";
      format-h = "󰓅 {used}GB";
      format-c = " {used}GB";
      format-alt = "󰾆 {percentage}%";
      max-length = 10;
      tooltip = true;
      tooltip-format = "󰾆 {percentage}%\n {used:0.1f}GB/{total:0.1f}GB";
    };

    cpu = {
      interval = 1;
      format = "CPU {usage:>2}% {icon0}{icon1}{icon2}{icon3}";
      format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
    };

    network = {
      tooltip = true;
      format-wifi = "   {essid}";
      format-ethernet = "󰈀 ";
      tooltip-format = "Network: <big><b>{essid}</b></big>\nSignal strength: <b>{signaldBm}dBm ({signalStrength}%)</b>\nFrequency: <b>{frequency}MHz</b>\nInterface: <b>{ifname}</b>\nIP: <b>{ipaddr}/{cidr}</b>\nGateway: <b>{gwaddr}</b>\nNetmask: <b>{netmask}</b>";
      format-linked = "󰈀 {ifname} (No IP)";
      format-disconnected = "󰖪 ";
      tooltip-format-disconnected = "Disconnected";
      format-alt = "<span foreground='#99ffdd'> {bandwidthDownBytes}</span> <span foreground='#ffcc66'> {bandwidthUpBytes}</span>";
      interval = 2;
    };

    "network#spd" = {
      interval = 1;
      format = "{ifname}";
      format-wifi = " {bandwidthDownBytes}  {bandwidthUpBytes}";
      format-ethernet = " {bandwidthDownBytes}  {bandwidthUpBytes}";
    };

    battery = {
      bat = "BAT0";
      interval = 60;
      states = {
        warning = 30;
        critical = 15;
      };
      events = {
        on-discharging-warning = "notify-send -u normal 'Low Battery'";
        on-discharging-critical = "notify-send -u critical 'Very Low Battery'";
        on-charging-100 = "notify-send -u normal 'Battery Full!'";
      };
      format = "{capacity}% {icon}";
      format-icons = ["" "" "" "" ""];
      max-length = 25;
    };
  };
}
