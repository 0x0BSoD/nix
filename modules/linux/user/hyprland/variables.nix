{...}: {
  # These settings belong to Hyprland, not to every login (including Plasma).
  wayland.windowManager.hyprland.settings.env = [
    "ANKI_WAYLAND,1"
    "CLUTTER_BACKEND,wayland"
    "DISABLE_QT5_COMPAT,0"
    "GDK_BACKEND,wayland"
    "GRIMBLAST_HIDE_CURSOR,0"
    "MOZ_ENABLE_WAYLAND,1"
    "NIXOS_OZONE_WL,1"
    "QT_AUTO_SCREEN_SCALE_FACTOR,1"
    "QT_QPA_PLATFORM,wayland"
    "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
    "SDL_VIDEODRIVER,wayland"
    "XDG_CURRENT_DESKTOP,Hyprland"
    "XDG_SESSION_DESKTOP,Hyprland"
    "XDG_SESSION_TYPE,wayland"
    "__GL_GSYNC_ALLOWED,0"
    "__GL_VRR_ALLOWED,0"
  ];
}
