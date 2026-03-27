{...}: {
  wayland.windowManager.hyprland.settings.exec-once = [
    "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    "hyperidle &"
    "nm-applet &"
    "poweralertd &"
    "quickshell -p /home/alex/.config/quickshell/shell.qml &"
    "swaync &"
    "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    "udiskie --automount --notify --smart-tray &"
    "waypaper --restore"
    "wl-clip-persist --clipboard both &"
    "wl-paste --watch cliphist store &"
  ];
}
