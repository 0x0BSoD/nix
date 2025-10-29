{...}: {
  programs.waybar.settings.mainBar = {
    position = "top";
    layer = "top";
    # height = 28;

    margin-top = 0;
    margin-bottom = 0;
    margin-left = 0;
    margin-right = 0;

    modules-left = [
      "hyprland/workspaces"
    ];
    modules-center = [
      "custom/media"
    ];
    modules-right = [
      "hyprland/language"
      "custom/notifications"
      "tray"
      "clock"
    ];

    clock = {
      calendar = {
        format = {
          today = "<span color='#98971A'><b>{}</b></span>";
        };
      };
      format = "  {:%H:%M}";
      tooltip = "true";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = "  {:%d/%m}";
    };

    "hyprland/workspaces" = {
      active-only = false;
      disable-scroll = true;
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        "1" = "I";
        "2" = "II";
        "3" = "III";
        "4" = "IV";
        "5" = "V";
        "6" = "VI";
        "7" = "VII";
        "8" = "VIII";
        "9" = "IX";
        "10" = "X";
        sort-by-number = true;
      };
      persistent-workspaces = {
        "1" = [];
        "2" = [];
        "3" = [];
        "4" = [];
        "5" = [];
      };
    };

    tray = {
      icon-size = 20;
      spacing = 8;
    };

    "hyprland/language" = {
      tooltip = true;
      tooltip-format = "Keyboard layout";
      format = "<span foreground='#FABD2F'> </span> {}";
      format-ru = "RU";
      format-en = "US";
      on-click = "hyprctl switchxkblayout at-translated-set-2-keyboard next";
    };

    "custom/notification" = {
      tooltip = true;
      tooltip-format = "Notifications";
      format = "{icon}";
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

    "custom/media" = {
      format = "{icon} {}";
      return-type = "json";
      max-length = 40;
      format-icons = {
        spotify = "";
        default = "🎜";
      };
      escape = true;
      exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null";
    };
  };
}
