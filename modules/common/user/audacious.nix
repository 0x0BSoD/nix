{pkgs, ...}: {
  home.packages = with pkgs; [
    audacious
    audacious-plugins
  ];
}
