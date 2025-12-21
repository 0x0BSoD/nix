{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.caskaydia-cove
    nerd-fonts.symbols-only
    twemoji-color-font
    noto-fonts-color-emoji
    fantasque-sans-mono
    banana-cursor
    catppuccin-kvantum
  ];

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    font = {
      name = "JetBrainsMono";
      size = 12;
    };
    theme = {
      name = "catppuccin-macchiato-blue-standard+default";
      package = pkgs.catppuccin-kvantum;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override {color = "blue";};
    };
    cursorTheme = {
      name = "Banana";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  home.pointerCursor = {
    name = "Banana";
    package = pkgs.banana-cursor;
    size = 24;
  };
}
