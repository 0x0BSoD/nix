{pkgs, ...}: {
  home.packages = with pkgs; [
    sysdig
  ];
}
