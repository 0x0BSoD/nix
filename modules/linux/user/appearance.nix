{
  pkgs,
  lib,
  ...
}: {
  # Force dark appearance globally
  home.sessionVariables = {
    # Force dark mode for various toolkits
    GTK_THEME = "Nordic";
    QT_STYLE_OVERRIDE = "kvantum-dark";
    QT_QPA_PLATFORMTHEME = lib.mkForce "qtct";

    # Force dark mode for GNOME applications
    GNOME_THEME = "Nordic";

    # Force dark mode for KDE applications
    KDE_THEME = "Nordic";
  };

  # Cursor theme - Nordzy cursor for complete Nord theme
  home.pointerCursor = {
    name = "Nordzy-cursors";
    package = pkgs.nordzy-cursor-theme;
    size = 24;
    hyprcursor.enable = true;
  };

  # QT configuration for Nord theme
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style = {
      name = "kvantum-dark";
      package = pkgs.libsForQt5.qt5ct;
    };
  };

  # Kvantum theme configuration for QT applications
  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Nordic-Darker

    [Applications]
    kvantum-dark@Nordic-Darker=true
  '';

  xdg.configFile."Kvantum/Nordic-Darker/Nordic-Darker.kvconfig".text = ''
    [General]
    comment=Nordic Darker Kvantum Theme
    version=1.0
    author=Nordic Theme
    useHacks=true

    [Colors:Window]
    BackgroundNormal=#2E3440
    BackgroundAlternate=#3B4252
    ForegroundNormal=#D8DEE9
    ForegroundInactive=#81A1C1
    ForegroundDisabled=#4C566A
    ForegroundActive=#88C0D0
    ForegroundLink=#5E81AC
    ForegroundVisited=#B48EAD
    ForegroundNegative=#BF616A
    ForegroundNeutral=#EBCB8B
    ForegroundPositive=#A3BE8C
    DecorationFocus=#5E81AC
    DecorationHover=#81A1C1

    [Colors:Button]
    BackgroundNormal=#3B4252
    BackgroundAlternate=#434C5E
    ForegroundNormal=#D8DEE9
    ForegroundInactive=#81A1C1
    ForegroundDisabled=#4C566A
    ForegroundActive=#88C0D0
    ForegroundLink=#5E81AC
    ForegroundVisited=#B48EAD
    ForegroundNegative=#BF616A
    ForegroundNeutral=#EBCB8B
    ForegroundPositive=#A3BE8C
    DecorationFocus=#5E81AC
    DecorationHover=#81A1C1

    [Colors:Selection]
    BackgroundNormal=#4C566A
    BackgroundAlternate=#434C5E
    ForegroundNormal=#ECEFF4
    ForegroundInactive=#D8DEE9
    ForegroundDisabled=#4C566A
    ForegroundActive=#88C0D0
    ForegroundLink=#5E81AC
    ForegroundVisited=#B48EAD
    ForegroundNegative=#BF616A
    ForegroundNeutral=#EBCB8B
    ForegroundPositive=#A3BE8C
    DecorationFocus=#5E81AC
    DecorationHover=#81A1C1

    [Colors:Tooltip]
    BackgroundNormal=#3B4252
    BackgroundAlternate=#434C5E
    ForegroundNormal=#D8DEE9
    ForegroundInactive=#81A1C1
    ForegroundDisabled=#4C566A
    ForegroundActive=#88C0D0
    ForegroundLink=#5E81AC
    ForegroundVisited=#B48EAD
    ForegroundNegative=#BF616A
    ForegroundNeutral=#EBCB8B
    ForegroundPositive=#A3BE8C
    DecorationFocus=#5E81AC
    DecorationHover=#81A1C1

    [Colors:View]
    BackgroundNormal=#2E3440
    BackgroundAlternate=#3B4252
    ForegroundNormal=#D8DEE9
    ForegroundInactive=#81A1C1
    ForegroundDisabled=#4C566A
    ForegroundActive=#88C0D0
    ForegroundLink=#5E81AC
    ForegroundVisited=#B48EAD
    ForegroundNegative=#BF616A
    ForegroundNeutral=#EBCB8B
    ForegroundPositive=#A3BE8C
    DecorationFocus=#5E81AC
    DecorationHover=#81A1C1

    [Colors:Window:Disabled]
    BackgroundNormal=#2E3440
    BackgroundAlternate=#3B4252
    ForegroundNormal=#4C566A
    ForegroundInactive=#4C566A
    ForegroundDisabled=#4C566A
    ForegroundActive=#4C566A
    ForegroundLink=#4C566A
    ForegroundVisited=#4C566A
    ForegroundNegative=#4C566A
    ForegroundNeutral=#4C566A
    ForegroundPositive=#4C566A
    DecorationFocus=#4C566A
    DecorationHover=#4C566A

    [Colors:Button:Disabled]
    BackgroundNormal=#3B4252
    BackgroundAlternate=#434C5E
    ForegroundNormal=#4C566A
    ForegroundInactive=#4C566A
    ForegroundDisabled=#4C566A
    ForegroundActive=#4C566A
    ForegroundLink=#4C566A
    ForegroundVisited=#4C566A
    ForegroundNegative=#4C566A
    ForegroundNeutral=#4C566A
    ForegroundPositive=#4C566A
    DecorationFocus=#4C566A
    DecorationHover=#4C566A

    [Colors:Selection:Disabled]
    BackgroundNormal=#4C566A
    BackgroundAlternate=#434C5E
    ForegroundNormal=#4C566A
    ForegroundInactive=#4C566A
    ForegroundDisabled=#4C566A
    ForegroundActive=#4C566A
    ForegroundLink=#4C566A
    ForegroundVisited=#4C566A
    ForegroundNegative=#4C566A
    ForegroundNeutral=#4C566A
    ForegroundPositive=#4C566A
    DecorationFocus=#4C566A
    DecorationHover=#4C566A

    [Colors:Tooltip:Disabled]
    BackgroundNormal=#3B4252
    BackgroundAlternate=#434C5E
    ForegroundNormal=#4C566A
    ForegroundInactive=#4C566A
    ForegroundDisabled=#4C566A
    ForegroundActive=#4C566A
    ForegroundLink=#4C566A
    ForegroundVisited=#4C566A
    ForegroundNegative=#4C566A
    ForegroundNeutral=#4C566A
    ForegroundPositive=#4C566A
    DecorationFocus=#4C566A
    DecorationHover=#4C566A

    [Colors:View:Disabled]
    BackgroundNormal=#2E3440
    BackgroundAlternate=#3B4252
    ForegroundNormal=#4C566A
    ForegroundInactive=#4C566A
    ForegroundDisabled=#4C566A
    ForegroundActive=#4C566A
    ForegroundLink=#4C566A
    ForegroundVisited=#4C566A
    ForegroundNegative=#4C566A
    ForegroundNeutral=#4C566A
    ForegroundPositive=#4C566A
    DecorationFocus=#4C566A
    DecorationHover=#4C566A
  '';

  # GTK configuration for Nord theme
  gtk = {
    enable = true;

    # Force dark color scheme
    colorScheme = "dark";
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    # Font configuration
    font = {
      name = "JetBrainsMono";
      size = 12;
    };

    # Nord theme for GTK
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };

    # Nord icon theme
    iconTheme = {
      name = "Nordzy";
      package = pkgs.nordzy-icon-theme;
    };

    # Cursor theme - Nordzy cursor for complete Nord theme
    cursorTheme = {
      name = "Nordzy-cursors";
      size = 24;
      package = pkgs.nordzy-cursor-theme;
    };
  };

  # Additional theming for specific applications
  xdg.configFile = {
    # Force dark mode for Electron apps
    "electron-flags.conf".text = ''
      --force-dark-mode
      --enable-features=WebUIDarkMode
    '';

    # Force dark mode for Chromium/Chrome based browsers
    "chromium-flags.conf".text = ''
      --force-dark-mode
      --enable-features=WebUIDarkMode
    '';

    # GTK settings for consistent dark theme
    "gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=1
      gtk-theme-name=Nordic
      gtk-icon-theme-name=Nordzy
      gtk-font-name=JetBrainsMono 12
      gtk-cursor-theme-name=Nordzy-cursors
      gtk-cursor-theme-size=24
      gtk-toolbar-style=GTK_TOOLBAR_BOTH
      gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
      gtk-button-images=1
      gtk-menu-images=1
      gtk-enable-event-sounds=1
      gtk-enable-input-feedback-sounds=1
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle=hintfull
      gtk-xft-rgba=rgb
    '';

    # GTK4 settings
    "gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=1
      gtk-theme-name=Nordic
      gtk-icon-theme-name=Nordzy
      gtk-font-name=JetBrainsMono 12
      gtk-cursor-theme-name=Nordzy-cursors
      gtk-cursor-theme-size=24
      gtk-enable-primary-paste=1
    '';
  };
}
