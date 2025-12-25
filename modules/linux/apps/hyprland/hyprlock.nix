{...}: {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        no_fade_in = false;
        grace = 0;
        disable_loading_bar = false;
      };

      background = [
        {
          path = "${../../../../wallpapers/astronaut.jpg}";
          blur_passes = 3;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      shape = [
        {
          size = "280, 55";
          color = "rgba(255, 255, 255, .1)";
          rounding = -1;
          border_size = 0;
          border_color = "rgba(253, 198, 135, 0)";
          rotate = 0;
          xray = false; # if true, make a "hole" in the background (rectangle of specified size, no rotation)

          position = "0, -130";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        # User
        {
          text = "    $USER";
          color = "rgba(216, 222, 233, 0.80)";
          outline_thickness = 2;
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          font_size = 18;
          font_family = "SF Pro Display Bold";
          position = "0, -130";
          halign = "center";
          valign = "center";
        }

        # Time
        {
          text = ''cmd[update:1000] echo "<span>$(date +'%I:%M')</span>"'';
          color = "rgba(216, 222, 233, 0.90)";
          font_size = 120;
          font_family = "SF Pro Display Bold";
          position = "0, 230";
          halign = "center";
          valign = "center";
        }

        # Date
        {
          text = ''cmd[update:1000] echo -e "$(LC_TIME=en_US.UTF-8 date +'%A, %B %d')"'';
          color = "rgba(216, 222, 233, 0.90)";
          font_size = 25;
          font_family = "SF Pro Display Semibold";
          position = "0, 350";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          size = "280, 55";
          outline_thickness = 2;
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(255, 255, 255, 0.1)";
          font_color = "rgb(200, 200, 200)";
          fade_on_empty = false;
          font_family = "SF Pro Display Bold";
          placeholder_text = ''<i><span foreground="##ffffff99">🔒 Enter Pass</span></i>'';
          hide_input = false;
          position = "0, -210";
          halign = "center";
          valign = "center";
        }
      ];

      animation = ["inputFieldColors, 0"];
    };
  };

  # Hypridle policy
  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
      lock_cmd = pidof hyprlock || hyprlock
      before_sleep_cmd = pidof hyprlock || hyprlock
      after_sleep_cmd = hyprctl dispatch dpms on
    }

    # Lock after 5 minutes
    listener {
      timeout = 300
      on-timeout = pidof hyprlock || hyprlock
    }

    # Turn screens off after 10 minutes
    listener {
      timeout = 600
      on-timeout = hyprctl dispatch dpms off
      on-resume = hyprctl dispatch dpms on
    }

    # Suspend after 30 minutes
    listener {
      timeout = 1800
      on-timeout = systemctl suspend
    }
  '';
}
