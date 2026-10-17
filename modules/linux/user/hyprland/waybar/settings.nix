{pkgs, ...}: let
  languageIndicator = pkgs.writeShellApplication {
    name = "waybar-language";
    runtimeInputs = [pkgs.hyprland pkgs.jq pkgs.socat];
    text = builtins.readFile ./language.sh;
  };
  spotifyIndicator = pkgs.writeShellApplication {
    name = "waybar-spotify";
    runtimeInputs = [pkgs.playerctl pkgs.jq];
    text = ''
      if ! status=$(playerctl --player=spotify status 2>/dev/null); then
        printf '{"text":"","tooltip":"","class":"stopped"}\n'
        exit 0
      fi

      artist=$(playerctl --player=spotify metadata artist 2>/dev/null || true)
      title=$(playerctl --player=spotify metadata title 2>/dev/null || true)
      icon=""
      if [ "$status" = "Playing" ]; then
        icon=""
      fi

      jq -cn --arg artist "$artist" --arg title "$title" \
        --arg status "$status" --arg icon "$icon" '{
          text: (" " + $icon + " " + ([$artist, $title] | map(select(length > 0)) | join(" — "))),
          tooltip: ([$artist, $title, $status, "Click: play/pause · Middle: previous · Right: next"] | join("\n")),
          class: ($status | ascii_downcase)
        }'
    '';
  };

  telemetry = pkgs.writeText "waybar-telemetry.py" (builtins.readFile ./telemetry.py);
  runcatFont = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/bzglve/runcat-text/30ed3dbbe331418d7cd8d79ad7d8eec06aeab17e/runcat.ttf";
    hash = "sha256-cHlDvqee3emwBrJcHqqec8lZ4dWSa25/ITw4P3UwqQA=";
  };

  commonBar = {
    layer = "top";
    position = "top";
    exclusive = true;
    passthrough = false;
    spacing = 0;
    fixed-center = true;
    ipc = true;

    margin-top = 0;
    margin-left = 0;
    margin-right = 0;

    modules-left = [
      "hyprland/workspaces"
      "hyprland/window"
    ];

    modules-center = [
      "clock"
    ];

    modules-right = [
      "custom/recording"
      "network"
      "custom/language"
      "battery"
      "pulseaudio"
      "tray"
      "custom/notification"
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
      format = "{}";
      return-type = "json";
      max-length = 60;
      escape = true;
      exec = "${spotifyIndicator}/bin/waybar-spotify";
      interval = 2;
      on-click = "${pkgs.playerctl}/bin/playerctl --player=spotify play-pause";
      on-click-middle = "${pkgs.playerctl}/bin/playerctl --player=spotify previous";
      on-click-right = "${pkgs.playerctl}/bin/playerctl --player=spotify next";
    };

    "custom/runcat" = {
      exec = "${pkgs.python3}/bin/python3 ${telemetry} runcat";
      return-type = "json";
      restart-interval = 2;
      exec-on-event = false;
      on-click = "ghostty -e btop";
    };

    "custom/sensors" = {
      exec = "${pkgs.python3}/bin/python3 ${telemetry} sensors";
      return-type = "json";
      interval = 5;
      tooltip = true;
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
      format = " {title}";
      max-length = 25;
      separate-outputs = true;
    };

    "hyprland/workspaces" = {
      active-only = false;
      all-outputs = true;
      on-click = "activate";
      on-scroll-up = "hyprctl dispatch workspace e+1";
      on-scroll-down = "hyprctl dispatch workspace e-1";
      show-special = false;
      persistent-workspaces = {
        # Explicit IDs keep one shared set instead of five per output.
        "*" = [1 2 3 4 5];
      };
      format = "{icon}";
      format-icons = {
        active = "<span font='12'>󰮯</span>";
        empty = "<span font='8'></span>";
        default = "󰊠";
      };
    };

    tray = {
      icon-size = 16;
      spacing = 8;
    };

    "custom/recording" = {
      exec = "screen-record bar";
      return-type = "json";
      interval = 1;
      on-click = "screen-record stop";
      escape = true;
      tooltip = true;
    };

    "custom/language" = {
      exec = "${languageIndicator}/bin/waybar-language";
      return-type = "json";
      restart-interval = 1;
      exec-on-event = false;
      on-click = "${pkgs.hyprland}/bin/hyprctl switchxkblayout all next";
      tooltip = true;
    };

    clock = {
      interval = 1;
      format = "{:%H:%M:%S  //  %Y.%m.%d}";
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
      format-muted = "  Muted";
      on-click = "ghostty --class=wiremix -e wiremix";
      on-click-right = "pamixer -t";
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
      format = " {used}GB";
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
      format = " {usage:>2}% {icon0}{icon1}{icon2}{icon3}";
      format-icons = ["⣀" "⣀" "⣄" "⣤" "⣦" "⣶" "⣷" "⣿"];
    };

    network = {
      tooltip = true;
      on-click = "nm-connection-editor";
      format-wifi = "  ";
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
      format-linked = "{ifname}: No IP";
      format-disconnected = "󰖪 Offline";
      tooltip-format = "{ifname}\n↓ Download: {bandwidthDownBytes}\n↑ Upload: {bandwidthUpBytes}";
    };

    battery = {
      bat = "BAT0";
      events = {
        on-discharging-warning = "notify-send -u normal 'Low Battery'";
        on-discharging-critical = "notify-send -u critical 'Very Low Battery'";
        on-charging-100 = "notify-send -u normal 'Battery Full!'";
      };
      interval = 10;
      states = {
        warning = 25;
        critical = 12;
      };
      format = "{icon} {capacity}%";
      format-charging = " {capacity}%";
      format-plugged = " {capacity}%";
      format-icons = ["" "" "" "" ""];
    };

    "custom/notification" = {
      tooltip = true;
      tooltip-format = "Notifications";
      format = "{icon} ";
      format-icons = {
        notification = "<span foreground='red'><sup></sup></span>";
        none = "";
        dnd-notification = "<span foreground='red'><sup></sup></span>";
        dnd-none = "";
        inhibited-notification = "<span foreground='red'><sup></sup></span>";
        inhibited-none = "";
        dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
        dnd-inhibited-none = "";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      on-click = "swaync-client -t -sw";
      on-click-right = "swaync-client -d -sw";
      escape = true;
    };

    "custom/audio-sink" = {
      exec = "audio-switch status";
      return-type = "json";
      interval = 3;
      on-click = "audio-switch cycle && pkill -SIGRTMIN+8 waybar";
      tooltip = true;
      signal = 8; # SIGRTMIN+8 — waybar uses 34+N, so signal 8 = SIGRTMIN+8
    };
  };
in {
  fonts.fontconfig.enable = true;
  xdg.dataFile."fonts/runcat.ttf".source = runcatFont;

  programs.waybar.settings = {
    mainBar =
      commonBar
      // {
        output = "eDP-1";
      };
    secondaryBar =
      commonBar
      // {
        output = "DP-1";
        modules-center = ["custom/playerctl"];
        modules-right = ["network#spd" "custom/runcat" "cpu" "memory" "custom/sensors"];
      };
  };
}
