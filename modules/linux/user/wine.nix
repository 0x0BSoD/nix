{pkgs, ...}: {
  home.packages = with pkgs; [
    bottles
    winetricks
    wineWow64Packages.waylandFull
  ];
}
