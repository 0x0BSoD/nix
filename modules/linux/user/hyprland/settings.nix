{...}: {
  wayland.windowManager.hyprland.settings = {
    # Hyprlang variables must be declared at global scope, not inside a
    # category — newer Hyprland no longer exports category-scoped vars.
    "$mainMod" = "SUPER";

    general = {
      layout = "dwindle";
      "col.active_border" = "rgb(8aadf4) rgb(24273A) rgb(24273A) rgb(8aadf4) 45deg";
      "col.inactive_border" = "rgb(24273A) rgb(24273A) rgb(24273A) rgb(27273A) 45deg";
      border_size = 0;
      gaps_in = 4;
      gaps_out = 4;
      float_gaps = 6;
      resize_on_border = true;
      extend_border_grab_area = 30;
    };

    misc = {
      disable_hyprland_logo = true;
      always_follow_on_dnd = true;
      layers_hog_keyboard_focus = true;
      animate_manual_resizes = false;
      enable_swallow = true;
      focus_on_activate = true;
      # new_window_takes_over_fullscreen removed in Hyprland 0.55 (no replacement).
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
      # pseudotile option removed in Hyprland 0.55; pseudotiling is now
      # toggled only via the `pseudo` dispatcher (see $mainMod, P bind).
      preserve_split = "yes";
    };

    master = {
      new_status = "master";
      special_scale_factor = 1;
    };

    decoration = {
      rounding = 4;
      active_opacity = 1.0;
      inactive_opacity = 1.0;
      blur = {
        enabled = false;
      };
      shadow = {
        enabled = false;
      };
    };

    animations = {
      enabled = "yes";
      bezier = ["myBezier, 0.05, 0.9, 0.1, 1.05"];
      animation = [
        # Windows pop in instead of sliding
        "windows, 1, 5, myBezier, popin 80%"
        "windowsOut, 1, 5, myBezier, popin 80%"

        # Layers (rofi, waybar) set to fade to remove the up/down slide
        "layers, 1, 5, myBezier, fade"
        "layersIn, 1, 5, myBezier, fade"
        "layersOut, 1, 5, myBezier, fade"

        "fade, 1, 5, myBezier"

        # Workspaces slide horizontally (standard)
        "workspaces, 1, 5, myBezier, slide"

        # Special workspaces fade to avoid the vertical slide
        "specialWorkspaceIn, 1, 5, myBezier, fade"
        "specialWorkspaceOut, 1, 5, myBezier, fade"
      ];
    };

    xwayland = {
      force_zero_scaling = true;
    };

    # No gaps when only one window on the workspace
    workspace = [
      "w[t1], gapsout:0, gapsin:0"
      "w[tg1], gapsout:0, gapsin:0"
      "f[1], gapsout:0, gapsin:0"
    ];
  };
}
