{...}: {
  programs.waybar.settings.mainBar = {
    position = "top";
    layer = "top";
    mode = "dock";
    exclusive = true;
    passthrough = false;
    gtk-layer-shell = true;

    height = 0;

    margin-bottom = 10;

    modules-left = [
      "clock"
      "hyprland/workspaces"
    ];

    modules-center = [
      "hyprland/window"
    ];

    modules-right = [
      "tray"
      "memory"
      "cpu"
      "network"
      "pulseaudio"
    ];

    #================================

    "hyprland/window" = {
      format = "󰣇 {}";
    };

    "hyprland/workspaces" = {
      disable-scroll = true;
      all-outputs = true;
      on-click = "activate";
    };

    tray = {
      icon-size = 13;
      spacing = 10;
    };

    clock = {
      format = "{:%A    %B-%d-%Y    %I:%M:%S %p}";
      interval = 1;
      rotate = 0;
      tooltip-format = "<tt>{calendar}</tt>";
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
      interval = 10;
      format = "󰍛 {usage}%";
      format-alt = "{icon0}{icon1}{icon2}{icon3}";
      format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
    };

    network = {
      tooltip = true;
      format-wifi = "  {essid}";
      format-ethernet = "󰈀 ";
      tooltip-format = "Network: <big><b>{essid}</b></big>\nSignal strength: <b>{signaldBm}dBm ({signalStrength}%)</b>\nFrequency: <b>{frequency}MHz</b>\nInterface: <b>{ifname}</b>\nIP: <b>{ipaddr}/{cidr}</b>\nGateway: <b>{gwaddr}</b>\nNetmask: <b>{netmask}</b>";
      format-linked = "󰈀 {ifname} (No IP)";
      format-disconnected = "󰖪 ";
      tooltip-format-disconnected = "Disconnected";
      format-alt = "<span foreground='#99ffdd'> {bandwidthDownBytes}</span> <span foreground='#ffcc66'> {bandwidthUpBytes}</span>";
      interval = 2;
    };
  };
}
