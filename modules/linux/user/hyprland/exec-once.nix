{...}: {
  wayland.windowManager.hyprland.extraConfig = ''
    hl.on("hyprland.start", function()
      hl.exec_cmd("hypridle")
      hl.exec_cmd("poweralertd")
      hl.exec_cmd("swaync")
      hl.exec_cmd("waybar")
      hl.exec_cmd("udiskie --automount --notify --smart-tray")
      hl.exec_cmd("awww-daemon")
      hl.exec_cmd("waypaper --restore")
      hl.exec_cmd("wl-clip-persist --clipboard both")
      hl.exec_cmd("wl-paste --watch cliphist store")
    end)

    -- Stop session services before returning to SDDM.
    hl.on("hyprland.shutdown", function()
      hl.exec_cmd("systemctl --user stop hyprland-session.target")
    end)
  '';
}
