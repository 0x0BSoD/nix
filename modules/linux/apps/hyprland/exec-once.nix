{...}: {
  wayland.windowManager.hyprland.settings.exec-once = [
    "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    "nm-applet &"
    "poweralertd &"
    "wl-clip-persist --clipboard both &"
    "wl-paste --watch cliphist store &"
    "waybar &"
    "swaync &"
    "vicinae server &"
    "udiskie --automount --notify --smart-tray &"
    "hyprctl setcursor Banana 24 &"
    "init-wallpaper &"
    "hyperidle &"
  ];
}
