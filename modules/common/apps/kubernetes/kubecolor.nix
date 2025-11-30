{pkgs, ...}: {
  home.packages = with pkgs; [
    kubecolor
  ];
}
