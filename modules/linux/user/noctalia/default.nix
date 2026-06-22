{inputs, ...}: {
  imports = [inputs.noctalia.homeModules.default];

  programs.noctalia = {
    enable = true;
    # Run as a user service so it autostarts independently of the compositor
    # (works under both hyprland and niri).
    systemd.enable = true;
    # `settings` would write ~/.config/noctalia/config.toml read-only and clobber
    # in-app changes; left unset so the shell is configured through its UI.
  };
}
