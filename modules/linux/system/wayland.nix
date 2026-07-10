{pkgs, ...}: {
  programs.hyprland.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];

    config = {
      common.default = ["gtk"];

      hyprland = {
        default = ["hyprland" "gtk"];
        "org.freedesktop.impl.portal.ScreenCast" = ["hyprland"];
        "org.freedesktop.impl.portal.RemoteDesktop" = ["hyprland"];
      };
    };
  };
}
