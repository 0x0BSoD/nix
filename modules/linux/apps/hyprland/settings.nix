{...}: {
  wayland.windowManager.hyprland.settings = {
    general = {
      "$mainMod" = "SUPER";
      layout = "dwindle";
      gaps_in = 5;
      gaps_out = 5;
      border_size = 2;
      "col.active_border" = "rgb(8aadf4) rgb(24273A) rgb(24273A) rgb(8aadf4) 45deg";
      "col.inactive_border" = "rgb(24273A) rgb(24273A) rgb(24273A) rgb(27273A) 45deg";
      resize_on_border = true;
    };

    misc = {
      disable_hyprland_logo = true;
      always_follow_on_dnd = true;
      layers_hog_keyboard_focus = true;
      animate_manual_resizes = false;
      enable_swallow = true;
      focus_on_activate = true;
      new_window_takes_over_fullscreen = 2;
      middle_click_paste = false;
    };

    input = {
      kb_layout = "us,ru";
      kb_options = "grp:alt_caps_toggle";
      numlock_by_default = true;
      repeat_delay = 300;
      follow_mouse = 1;
      float_switch_override_focus = 0;
      mouse_refocus = 0;
      sensitivity = 0;
      touchpad = {
        natural_scroll = true;
      };
    };

    dwindle = {
      pseudotile = "yes";
      preserve_split = "yes";
    };

    master = {
      new_status = "master";
      special_scale_factor = 1;
    };

    decoration = {
      rounding = 10;

      active_opacity = 1.0;
      inactive_opacity = 1.0;

      blur = {
        enabled = true;
        size = 3;
        passes = 3;
        ignore_opacity = true;
        vibrancy = 0.1696;
        new_optimizations = true;
      };

      shadow = {
        enabled = true;

        ignore_window = true;
        offset = "0 2";
        range = 20;
        render_power = 3;
        color = "rgba(00000055)";
      };
    };

    animations = {
      enabled = true;

      bezier = [
        "wind, 0.05, 0.9, 0.1, 1.05"
        "winIn, 0.1, 1.1, 0.1, 1.1"
        "winOut, 0.3, -0.3, 0, 1"
        "liner, 1, 1, 1, 1"
      ];

      animation = [
        # name, enable, speed, curve, style
        "windows,     1, 6,  wind, slide"
        "windowsIn,   1, 6,  winIn, slide"
        "windowsOut,  1, 5,  winOut, slide"
        "windowsMove, 1, 5,  wind, slide"
        "border,      1, 1,  liner"
        "borderangle, 1, 30, liner, loop"
        "fade,        1, 10, default"
        "workspaces,  1, 5,  wind"
      ];
    };

    xwayland = {
      force_zero_scaling = true;
    };
  };
}
