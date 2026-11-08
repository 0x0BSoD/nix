{
  lib,
  pkgs,
  ...
}: {
  services.hyprpolkitagent.enable = true;

  # The default graphical-session target also runs in Plasma.
  systemd.user.services.hyprpolkitagent = {
    Unit.PartOf = lib.mkForce ["hyprland-session.target"];
    Unit.After = lib.mkForce ["hyprland-session.target"];
    Install.WantedBy = lib.mkForce ["hyprland-session.target"];
  };

  home.packages = with pkgs; [
    hypridle
    poweralertd
    udiskie
    swappy
    mission-center
  ];
  wayland.windowManager.hyprland = {
    enable = true;

    # Generate hyprland.lua regardless of the Home Manager state version.
    configType = "lua";

    package = null;
    portalPackage = null;

    xwayland.enable = true;
    systemd.enable = true;
    systemd.enableXdgAutostart = true;
  };
}
