{...}: {
  wayland.windowManager.hyprland.settings.exec-once = [
    "hyperidle &"
    "nm-applet &"
    "poweralertd &"
    "swaync &"
    "waybar &"
    "udiskie --automount --notify --smart-tray &"
    "waypaper --restore"
    "wl-clip-persist --clipboard both &"
    "wl-paste --watch cliphist store &"
  ];
}
