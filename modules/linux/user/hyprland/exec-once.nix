{...}: {
  wayland.windowManager.hyprland.settings.exec-once = [
    "hypridle &"
    "poweralertd &"
    "swaync &"
    "waybar &"
    "udiskie --automount --notify --smart-tray &"
    "awww-daemon &"
    "waypaper --restore"
    "wl-clip-persist --clipboard both &"
    "wl-paste --watch cliphist store &"
  ];
  # Stop session services before returning to SDDM to choose another desktop.
  wayland.windowManager.hyprland.settings.exec-shutdown = [
    "systemctl --user stop hyprland-session.target"
  ];
}
