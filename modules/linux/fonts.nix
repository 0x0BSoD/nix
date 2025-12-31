{pkgs, ...}: {
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      # icon fonts
      material-symbols
      twemoji-color-font
      noto-fonts-color-emoji

      # Sans(Serif) fonts
      libertinus
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      roboto
      (google-fonts.override {fonts = ["Inter"];})
      fantasque-sans-mono

      # monospace fonts
      jetbrains-mono

      # nerdfonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      nerd-fonts.fira-code
      nerd-fonts.caskaydia-cove
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
