{pkgs, ...}: {
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      # icon fonts
      material-symbols

      # Sans(Serif) fonts
      libertinus
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      roboto
      (google-fonts.override {fonts = ["Inter"];})

      # monospace fonts
      jetbrains-mono

      # nerdfonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
    ];

    enableDefaultPackages = false;

    fontconfig = {
      enable = true;
      antialias = true;
      defaultFonts = {
        serif = ["Libertinus Serif"];
        sansSerif = ["Inter"];
        monospace = ["JetBrains Mono Nerd Font"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
