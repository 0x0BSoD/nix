{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    greetd.tuigreet
  ];

  users.users.greeter = {
    isNormalUser = false;
    description = "greetd greeter user";
    extraGroups = ["video" "audio"];
    linger = true;
  };

  services = {
    # Other
    printing.enable = true;
    libinput.enable = true;
    fstrim.enable = true;
    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    blueman.enable = true;
    tumbler.enable = true;
    hypridle.enable = true;

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet \
              --time --time-format '%I:%M %p | %a • %h | %F' \
              --cmd 'uwsm start hyprland'";
          user = "greeter";
        };
      };
    };

    # GUI
    gnome = {
      tinysparql.enable = true;
      gnome-keyring.enable = true;
    };

    dbus.enable = true;

    # needed for GNOME services outside of GNOME Desktop
    dbus.packages = with pkgs; [
      gcr
      gnome-settings-daemon
    ];

    logind.settings.Login = {
      # don’t shutdown when power button is short-pressed
      HandlePowerKey = "ignore";
    };

    # xserver.enable = true;
    # displayManager.gdm.enable = true;
    # desktopManager.gnome.enable = true;
    # xserver.xkb = {
    #   layout = "us";
    #   variant = "";
    # };

    # Sound
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      extraConfig.pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 256;
          "default.clock.min-quantum" = 256;
          "default.clock.max-quantum" = 256;
        };
      };
      extraConfig.pipewire-pulse."92-low-latency" = {
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "256/48000";
              pulse.default.req = "256/48000";
              pulse.max.req = "256/48000";
              pulse.min.quantum = "256/48000";
              pulse.max.quantum = "256/48000";
            };
          }
        ];
      };
    };
  };
}
