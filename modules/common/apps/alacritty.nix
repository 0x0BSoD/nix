{...}: {
  programs.alacritty = {
    enable = true;
    theme = "nord";
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      font = {
        size = 12;
        normal.family = "JetbrainsMono Nerd Font";
      };
      window = {
        opacity = 0.95;
        padding.x = 10;
        padding.y = 10;

        decorations = "Full";
        decorations_theme_variant = "Dark";
      };
    };
  };
}
