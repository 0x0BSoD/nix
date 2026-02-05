{pkgs, ...}: {
  home.pointerCursor = {
    name = "Banana";
    package = pkgs.banana-cursor;
    size = 24;
    hyprcursor.enable = true;
  };

  qt = {
    enable = true;
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    font = {
      name = "JetBrainsMono";
      size = 12;
    };
    theme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Banana";
      size = 24;
      package = pkgs.banana-cursor;
    };
  };
}
