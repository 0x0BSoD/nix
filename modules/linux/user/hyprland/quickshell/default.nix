{pkgs, ...}: {
  home.packages = [pkgs.quickshell];

  xdg.configFile."quickshell" = {
    source = ./qml;
    recursive = true;
  };
}
