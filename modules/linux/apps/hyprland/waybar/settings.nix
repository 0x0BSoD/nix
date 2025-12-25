{...}: {
  programs.waybar.settings.mainBar = {
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

    modules-left = [
      # "custom/playerctl"
      # "custom/separator_2"
      # "hyprland/window"

      "hyprland/workspaces"
      "custom/separator"
      "cpu"
      "custom/separator"
      "memory"
    ];

    modules-center = [
      # "hyprland/workspaces"
      # "clock"
      # "custom/separator"

      "hyprland/window"
    ];

    modules-right = [
      # "tray"

      "network#spd"
      "pulseaudio"
      "network"
      "custom/separator"
      "tray"
      "custom/separator"
      "battery"
      "custom/separator"
      "clock"
    ];

    #================================
    "custom/separator" = {
      format = "";
      interval = "once";
      tooltip = false;
    };

    "custom/separator_2" = {
      format = " ";
      interval = "once";
      tooltip = false;
    };
    #================================

    "custom/playerctl" = {
      format = "<span>{}</span>";
      return-type = "json";
      max-length = 25;
      exec = "playerctl -a metadata --format '{\"text\": \"{{artist}}  {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
      on-click-middle = "playerctl play-pause";
      on-click = "playerctl previous";
      on-click-right = "playerctl next";
      scroll-step = 5.0;
      on-scroll-up = "$HOME/.config/hypr/scripts/Volume.sh --inc";
      on-scroll-down = "$HOME/.config/hypr/scripts/Volume.sh --dec";
      smooth-scrolling-threshold = 1;
    };

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
      format = "{}";
      max-length = 25;
      separate-outputs = true;
      offscreen-css = true;
      offscreen-css-text = "(inactive)";
      rewrite = {
        "(.*) — Mozilla Firefox" = " $1";
        "(.*) - ghostty" = "> [$1]";
        "(.*) - zsh" = "> [$1]";
        "(.*) - $term" = "> [$1]";
      };
    };

    "hyprland/workspaces" = {
      active-only = false;
      all-outputs = true;
      on-click = "activate";
      on-scroll-up = "hyprctl dispatch workspace e+1";
      on-scroll-down = "hyprctl dispatch workspace e-1";
      show-special = false;
      persistent-workspaces = {
        "*" = 5;
      };
      format = "{icon}";
      format-icons = {
        active = "<span font='12'>󰮯</span>";
        empty = "<span font='8'></span>";
        default = "󰊠";
      };
    };

    tray = {
      icon-size = 15;
      spacing = 7;
    };

    clock = {
      interval = 1;
      format = " {:%H:%M:%S}";
      format-alt = " {:%H:%M   %Y, %d %B, %A}";
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
