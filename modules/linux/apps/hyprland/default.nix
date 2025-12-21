{...}: {
  imports = [
    ./hyprland.nix
    ./hyprlock.nix
    ./exec-once.nix
    ./monitors.nix
    ./settings.nix
    ./binds.nix
    ./windowrules.nix
    ./variables.nix
    ./swaync
    ./vicinae
    ./waybar
    ./rofi
  ];
}
