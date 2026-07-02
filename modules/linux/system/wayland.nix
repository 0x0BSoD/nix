{ pkgs, inputs, ... }:
{
  imports = [inputs.niri-flake.nixosModules.niri];

  programs.hyprland.enable = true;
  # To switch to niri: set to true here AND uncomment "${linuxPath}/niri" in the host user.nix
  programs.niri.enable = false;

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

      niri = {
        default = ["gnome" "gtk"];
        "org.freedesktop.impl.portal.ScreenCast" = ["gnome"];
        "org.freedesktop.impl.portal.RemoteDesktop" = ["gnome"];
      };
    };
  };
}
