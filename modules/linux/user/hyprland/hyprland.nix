{lib, pkgs, ...}: {
  services.hyprpolkitagent.enable = true;

  # The default graphical-session target also runs in Plasma.
  systemd.user.services.hyprpolkitagent = {
    Unit.PartOf = lib.mkForce ["hyprland-session.target"];
    Unit.After = lib.mkForce ["hyprland-session.target"];
    Install.WantedBy = lib.mkForce ["hyprland-session.target"];
  };

  home.packages = with pkgs; [
    hypridle
    networkmanagerapplet
    poweralertd
    udiskie
    swappy
    mission-center
  ];
  wayland.windowManager.hyprland = {
    enable = true;

    # Keep legacy default; new default ("lua") arrives with stateVersion >= 26.05
    configType = "hyprlang";

    package = null;
    portalPackage = null;

    xwayland.enable = true;
    systemd.enable = true;
    systemd.enableXdgAutostart = true;
  };
}
