{pkgs, ...}: {
  home.packages = with pkgs; [
    virtualbox
    k3s_1_35
    vagrant
  ];
}
