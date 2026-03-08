{...}: {
  wayland.windowManager.hyprland.settings.exec-once = [
    "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    "hyperidle &"
    "waypaper --restore"
    "nm-applet &"
    "poweralertd &"
    "swaync &"
    "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    "udiskie --automount --notify --smart-tray &"
    "vicinae server &"
    "waybar &"
    "wl-clip-persist --clipboard both &"
    "wl-paste --watch cliphist store &"
  ];
}
