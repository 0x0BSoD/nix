{ pkgs, inputs, ... }:
{
  programs.hyprland.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
    ];

    config = {
      common = {
        default = [ "gtk" "hyprland" ];
      };
      common."org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
      common."org.freedesktop.impl.portal.RemoteDesktop" = [ "hyprland" ];
    };
  };
}
