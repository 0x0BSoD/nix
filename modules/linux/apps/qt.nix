{pkgs, ...}: {
  home.packages = with pkgs; [
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum

    (catppuccin-kvantum.override {
      accent = "blue";
      variant = "macchiato";
    })
  ];

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Catppuccin-Macchiato-Blue
  '';
}
