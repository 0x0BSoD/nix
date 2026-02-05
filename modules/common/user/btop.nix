{...}: {
  programs.btop = {
    enable = true;

    settings = {
      color_theme = "default";
      theme_background = true;
      update_ms = 500;
      rounded_corners = true;
    };
  };
}
