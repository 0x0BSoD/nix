{...}: {
  wayland.windowManager.hyprland.settings = {
    config = {
      general = {
        layout = "dwindle";
        col = {
          active_border = {
            colors = ["rgb(8aadf4)" "rgb(24273A)" "rgb(24273A)" "rgb(8aadf4)"];
            angle = 45;
          };
          inactive_border = {
            colors = ["rgb(24273A)" "rgb(24273A)" "rgb(24273A)" "rgb(27273A)"];
            angle = 45;
          };
        };
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
        mouse_refocus = false;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };

      dwindle = {
        # pseudotile option removed in Hyprland 0.55; pseudotiling is now
        # toggled only via the `pseudo` dispatcher (see SUPER + P binding).
        preserve_split = true;
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

      animations.enabled = true;

      xwayland = {
        force_zero_scaling = true;
      };
    };

    curve = {
      _args = [
        "myBezier"
        {
          type = "bezier";
          points = [[0.05 0.9] [0.1 1.05]];
        }
      ];
    };
    animation = map (spec:
      {
        leaf = builtins.elemAt spec 0;
        enabled = true;
        speed = 5;
        bezier = "myBezier";
      }
      // (
        if builtins.length spec > 1
        then {style = builtins.elemAt spec 1;}
        else {}
      )) [
      ["windows" "popin 80%"]
      ["windowsOut" "popin 80%"]
      ["layers" "fade"]
      ["layersIn" "fade"]
      ["layersOut" "fade"]
      ["fade"]
      ["workspaces" "slide"]
      ["specialWorkspaceIn" "fade"]
      ["specialWorkspaceOut" "fade"]
    ];

    # No gaps when only one window is on the workspace.
    workspace_rule = map (workspace: {
      inherit workspace;
      gaps_out = 0;
      gaps_in = 0;
    }) ["w[t1]" "w[tg1]" "f[1]"];
  };
}
