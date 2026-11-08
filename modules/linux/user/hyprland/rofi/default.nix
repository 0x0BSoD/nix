{pkgs, ...}: let
  powerMenu = pkgs.writeShellApplication {
    name = "power-menu";
    runtimeInputs = with pkgs; [rofi hyprland hyprlock systemd];
    text = builtins.readFile ./power-menu.sh;
  };
in {
  home.packages = [pkgs.rofi powerMenu];

  xdg.configFile."rofi/theme.rasi".source = ./theme.rasi;
  xdg.configFile."rofi/config.rasi".source = ./config.rasi;

  xdg.configFile."rofi/powermenu-theme.rasi".source = ./powermenu-theme.rasi;
}
