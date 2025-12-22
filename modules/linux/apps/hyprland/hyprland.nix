{pkgs, ...}: {
  home.packages = with pkgs; [
    cliphist
    direnv
    glib
    grim
    grimblast
    hyprpicker
    slurp
    swww
    wayland
    wf-recorder
    wl-clip-persist
  ];
  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];
  wayland.windowManager.hyprland = {
    enable = true;

    package = null;
    portalPackage = null;

    xwayland = {
      enable = true;
    };
    systemd.enable = true;
  };
}
