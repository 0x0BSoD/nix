{pkgs, ...}: {
  home.packages = with pkgs; [
    # linux only
    # virtualbox
    # k3s
    vagrant
  ];
}
