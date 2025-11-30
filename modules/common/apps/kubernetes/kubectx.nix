{pkgs, ...}: {
  home.packages = with pkgs; [
    kubectx
  ];
}
