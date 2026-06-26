{...}: {
  services.hyprpolkitagent.enable = true;

  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];
  wayland.windowManager.hyprland = {
    enable = true;

    # Keep legacy default; new default ("lua") arrives with stateVersion >= 26.05
    configType = "hyprlang";

    package = null;
    portalPackage = null;

    xwayland.enable = true;
    systemd.enable = true;
  };
}
